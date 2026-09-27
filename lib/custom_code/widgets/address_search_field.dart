// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// ============================================================================
// FlutterFlow → Custom Code → Custom Widgets → + Add
// Имя виджета: AddressSearchField
// Ставится ТОЛЬКО в клиентский проект (neno / nado_clean)
//
// Зависимости: дополнительных нет (http уже в проекте)
//
// Поле поиска адреса с подсказками DaData. Пока пользователь печатает,
// над полем открывается список адресов. Выбор из списка:
//   - адрес с домом → список закрывается, клавиатура прячется,
//     вызывается onSelected — страница переносит карту на эту точку;
//   - улица без дома → текст подставляется в поле, список обновляется,
//     остаётся дописать номер дома.
// Enter выбирает первый адрес из списка, у которого есть координаты.
//
// Параметры виджета (Custom Widget → Parameters), все Nullable:
//   width        double
//   height       double
//   hintText     String   по умолчанию «Город, улица, дом»
//   initialText  String   текст в поле при открытии страницы
//
// Callbacks (Custom Widget → Parameters → тип Action), у каждого ОДИН параметр:
//   onSelected   параметр point    Double, Is List ✓ → [0] широта, [1] долгота
//   onAddress    параметр address  String, Is List ✓ → [0] адрес, [1] город
//   Сначала вызывается onAddress, потом onSelected.
//
//   Почему два callback, а не один с двумя параметрами: FlutterFlow в любой
//   параметр подставляет первый (даже если типы разные) и выдаёт
//   «return type mismatch». С одним параметром на callback всё работает.
// ============================================================================

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const String _kSuggestUrl =
    'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address';
const String _kSuggestApiKey = 'd224b2dba5b06da6396bffdb4fc4d66be7f5a324';

/// Сколько символов ввести, прежде чем идти в DaData.
const int _kMinChars = 3;

class AddressSearchField extends StatefulWidget {
  const AddressSearchField({
    super.key,
    this.width,
    this.height,
    this.hintText,
    this.initialText,
    this.onSelected,
    this.onAddress,
  });

  final double? width;
  final double? height;
  final String? hintText;
  final String? initialText;
  final Future Function(List<double> point)? onSelected;
  final Future Function(List<String> address)? onAddress;

  @override
  State<AddressSearchField> createState() => _AddressSearchFieldState();
}

class _Suggestion {
  _Suggestion(this.value, this.city, this.lat, this.lng, this.hasHouse);

  final String value;
  final String city;
  final double? lat;
  final double? lng;
  final bool hasHouse;

  bool get hasPoint => lat != null && lng != null;
}

class _AddressSearchFieldState extends State<AddressSearchField> {
  final _controller = TextEditingController();
  final _focus = FocusNode();
  final _link = LayerLink();
  final _overlay = OverlayPortalController();

  Timer? _debounce;
  int _requestId = 0;
  bool _loading = false;
  List<_Suggestion> _items = const [];

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialText ?? '';
    _focus.addListener(() {
      if (!_focus.hasFocus) _hideList();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _onChanged(String text) {
    _debounce?.cancel();
    if (text.trim().length < _kMinChars) {
      _requestId++;
      setState(() {
        _loading = false;
        _items = const [];
      });
      _hideList();
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () => _load(text));
  }

  Future<void> _load(String text) async {
    final id = ++_requestId;
    setState(() => _loading = true);
    final items = await _fetch(text.trim());
    // Пока шёл запрос, пользователь мог напечатать дальше — старый ответ
    // не показываем.
    if (!mounted || id != _requestId) return;
    setState(() {
      _loading = false;
      _items = items;
    });
    if (_focus.hasFocus) _overlay.show();
  }

  Future<List<_Suggestion>> _fetch(String query) async {
    try {
      final resp = await http
          .post(
            Uri.parse(_kSuggestUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Token $_kSuggestApiKey',
            },
            body: jsonEncode({
              'query': query,
              'count': 7,
              // Без города в запросе первой идёт Москва (КЛАДР 77).
              'locations_boost': [
                {'kladr_id': '77'},
              ],
            }),
          )
          .timeout(const Duration(seconds: 10));
      if (resp.statusCode != 200) return const [];

      final body =
          jsonDecode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;
      final list = body['suggestions'] as List? ?? const [];
      return [
        for (final s in list.cast<Map<String, dynamic>>())
          _Suggestion(
            '${s['value'] ?? ''}',
            // У деревень бывает только settlement, как в reverseGeocode.
            '${s['data']?['city'] ?? s['data']?['settlement'] ?? ''}',
            double.tryParse('${s['data']?['geo_lat']}'),
            double.tryParse('${s['data']?['geo_lon']}'),
            s['data']?['house'] != null,
          ),
      ];
    } catch (_) {
      return const [];
    }
  }

  void _pick(_Suggestion s) {
    if (!s.hasHouse) {
      // Улица без дома: подставляем и ждём номер дома.
      final text = '${s.value}, ';
      _controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
      _focus.requestFocus();
      _onChanged(text);
      return;
    }
    _select(s);
  }

  Future<void> _select(_Suggestion s) async {
    _debounce?.cancel();
    _requestId++;
    _controller.text = s.value;
    setState(() {
      _loading = false;
      _items = const [];
    });
    _hideList();
    _focus.unfocus();
    if (s.hasPoint) {
      await widget.onAddress?.call([s.value, s.city]);
      await widget.onSelected?.call([s.lat!, s.lng!]);
    }
  }

  Future<void> _onSubmitted(String text) async {
    _debounce?.cancel();
    final items = _items.isNotEmpty ? _items : await _fetch(text.trim());
    if (!mounted) return;
    final withPoint = items.where((s) => s.hasPoint);
    if (withPoint.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Адрес не найден')),
      );
      return;
    }
    _select(withPoint.first);
  }

  void _hideList() {
    if (_overlay.isShowing) _overlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return TapRegion(
      groupId: this,
      onTapOutside: (_) => _focus.unfocus(),
      child: CompositedTransformTarget(
        link: _link,
        child: OverlayPortal(
          controller: _overlay,
          overlayChildBuilder: _buildList,
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: TextField(
              controller: _controller,
              focusNode: _focus,
              onChanged: _onChanged,
              onSubmitted: _onSubmitted,
              onTap: () {
                if (_items.isNotEmpty) _overlay.show();
              },
              // В браузере поле само теряет фокус при нажатии мимо него —
              // в том числе на строку списка, и список пропадал раньше,
              // чем срабатывал выбор. Нажатия снаружи обрабатывает TapRegion
              // выше, он знает, что список — часть поля.
              onTapOutside: (_) {},
              textInputAction: TextInputAction.search,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: colors.surface,
                hintText: widget.hintText ?? 'Город, улица, дом',
                suffixIcon: _loading
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : _controller.text.isEmpty
                        ? const Icon(Icons.search)
                        : IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _controller.clear();
                              _onChanged('');
                            },
                          ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: colors.primary),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Список открывается НАД полем: поле внизу экрана, под ним клавиатура.
  /// Ширина — во весь экран с отступами 12, даже если поле узкое.
  Widget _buildList(BuildContext context) {
    final box = this.context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return const SizedBox.shrink();
    final media = MediaQuery.of(context);
    final fieldTopLeft = box.localToGlobal(Offset.zero);
    final listWidth = media.size.width - 24;
    final maxHeight = (fieldTopLeft.dy - media.padding.top - 16)
        .clamp(80.0, 320.0)
        .toDouble();

    final theme = Theme.of(context);
    return CompositedTransformFollower(
      link: _link,
      showWhenUnlinked: false,
      targetAnchor: Alignment.topLeft,
      followerAnchor: Alignment.bottomLeft,
      offset: Offset(12 - fieldTopLeft.dx, -6),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: TapRegion(
          groupId: this,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.surface,
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: listWidth,
                minWidth: listWidth,
                maxHeight: maxHeight,
              ),
              child: _items.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Ничего не найдено'),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _items.length,
                      separatorBuilder: (_, __) =>
                          const Divider(height: 1, indent: 48),
                      itemBuilder: (_, i) {
                        final s = _items[i];
                        return ListTile(
                          dense: true,
                          leading: Icon(
                            s.hasHouse
                                ? Icons.location_on_outlined
                                : Icons.signpost_outlined,
                          ),
                          title: Text(
                            s.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle:
                              s.hasHouse ? null : const Text('укажите дом'),
                          onTap: () => _pick(s),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the `</>` button on the right!
