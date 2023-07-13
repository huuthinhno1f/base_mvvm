import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configs/configs.dart';

//ignore: must_be_immutable
class WidgetInput extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? endIcon;
  final TextInputType? textInputType;
  final GestureTapCallback? endIconOnTap;
  bool obscureText;
  final String? hintText;
  final String? labelText;
  final Iterable<String>? autofill;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onSubmit;
  final double? heightSuffix;
  final double? widthSuffix;
  final double? radius;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final int? maxLines;
  final Color? bgColor;
  final bool showEye;
  final bool autoFocus;
  final int? maxLengthField;
  final Color? borderColor;
  final Widget? prefix;
  final Widget? action;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onEditingComplete;
  final BorderRadius? borderRadius;

  WidgetInput({
    Key? key,
    this.onTap,
    this.heightSuffix,
    this.readOnly = false,
    this.widthSuffix,
    this.onSubmit,
    this.hintText,
    this.labelText,
    this.contentPadding,
    this.onChanged,
    this.validator,
    this.controller,
    this.endIcon,
    this.textInputType = TextInputType.text,
    this.endIconOnTap,
    this.obscureText = false,
    this.style,
    this.hintStyle,
    this.maxLines,
    this.bgColor,
    this.inputFormatters,
    this.showEye = false,
    this.autofill,
    this.autoFocus = false,
    this.maxLengthField,
    this.onEditingComplete,
    this.borderColor,
    this.prefix,
    this.action,
    this.radius,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<WidgetInput> createState() => _WidgetInputState();
}

class _WidgetInputState extends State<WidgetInput> {
  TextStyle get defaultStyle => styleSmall;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextFormField(
          textInputAction: TextInputAction.done,
          maxLines: widget.maxLines ?? 1,
          maxLength: widget.maxLengthField,
          autofillHints: widget.autofill,
          onTap: widget.onTap,
          autocorrect: false,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmit,
          validator: widget.validator,
          readOnly: widget.readOnly,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          obscureText: widget.obscureText,
          obscuringCharacter: '*',
          cursorColor: Colors.black,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autoFocus,
          onEditingComplete: widget.onEditingComplete,
          decoration: InputDecoration(
              filled: true,
              fillColor: widget.bgColor ?? Colors.white,
              isCollapsed: true,
              isDense: true,
              prefixIcon: widget.prefix,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                          horizontal: 10 * AppValues.scale, vertical: 13 * AppValues.scale)
                      .copyWith(right: widget.showEye ? 60 * AppValues.scale : 0),
              hintText: widget.hintText ?? "",
              hintStyle: (widget.hintStyle ?? defaultStyle.copyWith(color: grey_02)),
              counterText: '',
              labelText: widget.labelText,
              labelStyle: styleMedium.copyWith(color: grey_04),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: _border(),
              focusedBorder: _border(),
              enabledBorder: _border(),
              suffixIconConstraints: BoxConstraints.tightFor(
                  width: widget.widthSuffix ?? 25 * AppValues.scale,
                  height: widget.heightSuffix ?? 25 * AppValues.scale)),
          style: widget.style ?? defaultStyle,
        ),
        widget.action != null
            ? widget.action!
            : widget.showEye
                ? Positioned(
                    right: 0,
                    top: 2 * AppValues.scale,
                    child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          height: 40 * AppValues.scale,
                          width: 60 * AppValues.scale,
                          child: Center(
                            child: Image.asset(
                                (widget.obscureText)
                                    ? AppImages.png('ic_show_pass')
                                    : AppImages.png('ic_un_show_pass'),
                                width: 20 * AppValues.scale,
                                height: 20 * AppValues.scale),
                          ),
                        ),
                        onTap: () => setState(() => widget.obscureText = !widget.obscureText)),
                  )
                : const SizedBox()
      ],
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: widget.borderColor ?? grey_01),
        borderRadius:
            widget.borderRadius ?? BorderRadius.circular(widget.radius ?? 99 * AppValues.scale));
  }
}
