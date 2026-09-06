import 'package:flutter/material.dart';

import '../../../core/utils/search_normalize.dart';

/// A typeahead field styled like a modern web form input: rounded, subtle
/// border, floating label, live-filtered dropdown that updates per
/// keystroke, with the matching substring bolded in each option.
///
/// Matching is case- and script-insensitive: it searches every string
/// [searchableText] returns for an option (e.g. a country's Persian *and*
/// English names at once), so typing in either script finds a match — see
/// core/utils/search_normalize.dart for why no transliteration is needed.
class AutocompleteField<T extends Object> extends StatefulWidget {
  const AutocompleteField({
    super.key,
    required this.label,
    required this.options,
    required this.searchableText,
    required this.optionDisplayText,
    required this.selected,
    required this.onSelected,
    required this.noResultsText,
    this.optionLeading,
  });

  final String label;
  final List<T> options;
  final List<String> Function(T option) searchableText;
  final String Function(T option) optionDisplayText;
  final T? selected;
  final ValueChanged<T> onSelected;
  final String noResultsText;
  final Widget Function(T option)? optionLeading;

  @override
  State<AutocompleteField<T>> createState() => _AutocompleteFieldState<T>();
}

class _AutocompleteFieldState<T extends Object>
    extends State<AutocompleteField<T>> {
  late final TextEditingController _controller = TextEditingController(
    text: _displayTextFor(widget.selected),
  );
  final FocusNode _focusNode = FocusNode();

  String _displayTextFor(T? option) =>
      option == null ? '' : widget.optionDisplayText(option);

  @override
  void didUpdateWidget(covariant AutocompleteField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      final text = _displayTextFor(widget.selected);
      if (_controller.text != text) {
        _controller.value = TextEditingValue(text: text);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<T> _filter(String rawQuery) {
    final query = normalizeSearchText(rawQuery.trim());
    if (query.isEmpty) return widget.options;
    return widget.options.where((option) {
      return widget
          .searchableText(option)
          .any((text) => normalizeSearchText(text).contains(query));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<T>(
      textEditingController: _controller,
      focusNode: _focusNode,
      displayStringForOption: widget.optionDisplayText,
      optionsBuilder: (value) => _filter(value.text),
      onSelected: widget.onSelected,
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: widget.label,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, optionsIterable) {
        final options = optionsIterable.toList();
        final query = normalizeSearchText(_controller.text.trim());
        return _AnimatedOptionsPanel(
          child: options.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(widget.noResultsText),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  shrinkWrap: true,
                  itemCount: options.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                    color: Theme.of(
                      context,
                    ).colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return InkWell(
                      onTap: () => onSelected(option),
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 48),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: AlignmentDirectional.centerStart,
                        child: Row(
                          children: [
                            if (widget.optionLeading case final leading?) ...[
                              leading(option),
                              const SizedBox(width: 12),
                            ],
                            Expanded(
                              child: _HighlightedText(
                                text: widget.optionDisplayText(option),
                                query: query,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

/// Wraps the options list so it feels like a real overlay materializing
/// out of the field — scaling and fading in from its top edge — rather
/// than snapping into existence. `RawAutocomplete` gives this widget a
/// fresh `optionsViewBuilder` call on every keystroke but keeps reusing the
/// same `State` (same widget type, same position in the overlay's tree),
/// so this entrance only plays once per focus-gain, not once per keystroke.
class _AnimatedOptionsPanel extends StatefulWidget {
  const _AnimatedOptionsPanel({required this.child});

  final Widget child;

  @override
  State<_AnimatedOptionsPanel> createState() => _AnimatedOptionsPanelState();
}

class _AnimatedOptionsPanelState extends State<_AnimatedOptionsPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
          alignment: Alignment.topCenter,
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(14),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 260),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class _HighlightedText extends StatelessWidget {
  const _HighlightedText({required this.text, required this.query});

  final String text;
  final String query;

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return Text(text);

    final matchIndex = normalizeSearchText(text).indexOf(query);
    if (matchIndex < 0) return Text(text);

    final baseStyle = DefaultTextStyle.of(context).style;
    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: text.substring(0, matchIndex)),
          TextSpan(
            text: text.substring(matchIndex, matchIndex + query.length),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: text.substring(matchIndex + query.length)),
        ],
      ),
    );
  }
}
