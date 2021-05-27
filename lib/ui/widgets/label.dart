import 'package:flutter/material.dart';

class Label extends StatefulWidget {
  final String? label;
  final Alignment? alignment;
  final double? paddingAll;
  final double? paddingTop;
  final double? paddingBottom;
  final double? paddingLeft;
  final double? paddingRight;
  final double? marginAll;
  final double? marginTop;
  final double? marginBottom;
  final double? marginLeft;
  final double? marginRight;
  final MaterialColor? backgroundColor;
  final double? radiusAll;
  final double? radiusTopLeft;
  final double? radiusTopRight;
  final double? radiusBottomLeft;
  final double? radiusBottomRight;
  final int? flex;
  final MaterialColor? shadowColor;
  final double? spreadRadius;
  final double? blurRadius;
  final double? offsetX;
  final double? offsetY;
  final MaterialColor? fontColor;
  final FontWeight? fontWeight;
  var fontFamily;
  final double? fontSize;
  final double? width;
  final double? height;

  Label(
      {Key? key,
      @required this.label,
      this.alignment,
      this.marginAll,
      this.marginBottom,
      this.marginLeft,
      this.marginRight,
      this.marginTop,
      this.paddingAll,
      this.paddingBottom,
      this.paddingLeft,
      this.paddingRight,
      this.paddingTop,
      this.backgroundColor,
      this.radiusAll,
      this.radiusBottomLeft,
      this.radiusBottomRight,
      this.radiusTopLeft,
      this.radiusTopRight,
      this.flex,
      this.shadowColor,
      this.blurRadius,
      this.offsetX,
      this.offsetY,
      this.spreadRadius,
      this.fontWeight,
      this.fontColor,
      this.fontFamily,
      this.fontSize,
      this.width,
      this.height})
      : super(key: key);

  @override
  _LabelState createState() => _LabelState();
}

class _LabelState extends State<Label> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex ?? 0,
      child: GestureDetector(
        child: widget.height == null && widget.width == null
            ? container()
            : widget.height == null && widget.width != null
                ? withWidth(widget.width!)
                : widget.height != null && widget.width == null
                    ? withHeight(widget.height!)
                    : withWidthAndHeight(widget.width!, widget.height!),
      ),
    );
  }

  Widget withWidth(double width) {
    return Container(
      width: width,
      padding: widget.paddingAll != null
          ? EdgeInsets.all(widget.paddingAll!)
          : EdgeInsets.only(
              top: widget.paddingTop ?? 0,
              bottom: widget.paddingBottom ?? 0,
              left: widget.paddingLeft ?? 0,
              right: widget.paddingRight ?? 0),
      margin: widget.marginAll != null
          ? EdgeInsets.all(widget.marginAll!)
          : EdgeInsets.only(
              top: widget.marginTop ?? 0,
              bottom: widget.marginBottom ?? 0,
              left: widget.marginLeft ?? 0,
              right: widget.marginRight ?? 0),
      alignment: widget.alignment ?? Alignment.center,
      decoration: BoxDecoration(
        borderRadius: widget.radiusAll != null
            ? BorderRadius.all(Radius.circular(widget.radiusAll ?? 0))
            : BorderRadius.only(
                topLeft: Radius.circular(widget.radiusTopLeft ?? 0),
                topRight: Radius.circular(widget.radiusTopRight ?? 0),
                bottomLeft: Radius.circular(widget.radiusBottomLeft ?? 0),
                bottomRight: Radius.circular(widget.radiusBottomRight ?? 0)),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor ?? Colors.transparent,
            spreadRadius: widget.spreadRadius ?? 0,
            blurRadius: widget.blurRadius ?? 0,
            offset: Offset(widget.offsetX ?? 0,
                widget.offsetY ?? 0), // changes position of shadow
          ),
        ],
        color: widget.backgroundColor ?? Colors.transparent,
      ),
      child: Text(
        widget.label!,
        style: TextStyle(
          color: widget.fontColor ?? Colors.black,
          fontSize: widget.fontSize ?? 12,
          fontFamily: widget.fontFamily ?? 'Montserrat',
          fontWeight: widget.fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }

  Widget withHeight(double height) {
    return Container(
      height: height,
      padding: widget.paddingAll != null
          ? EdgeInsets.all(widget.paddingAll!)
          : EdgeInsets.only(
              top: widget.paddingTop ?? 0,
              bottom: widget.paddingBottom ?? 0,
              left: widget.paddingLeft ?? 0,
              right: widget.paddingRight ?? 0),
      margin: widget.marginAll != null
          ? EdgeInsets.all(widget.marginAll!)
          : EdgeInsets.only(
              top: widget.marginTop ?? 0,
              bottom: widget.marginBottom ?? 0,
              left: widget.marginLeft ?? 0,
              right: widget.marginRight ?? 0),
      alignment: widget.alignment ?? Alignment.center,
      decoration: BoxDecoration(
        borderRadius: widget.radiusAll != null
            ? BorderRadius.all(Radius.circular(widget.radiusAll ?? 0))
            : BorderRadius.only(
                topLeft: Radius.circular(widget.radiusTopLeft ?? 0),
                topRight: Radius.circular(widget.radiusTopRight ?? 0),
                bottomLeft: Radius.circular(widget.radiusBottomLeft ?? 0),
                bottomRight: Radius.circular(widget.radiusBottomRight ?? 0)),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor ?? Colors.transparent,
            spreadRadius: widget.spreadRadius ?? 0,
            blurRadius: widget.blurRadius ?? 0,
            offset: Offset(widget.offsetX ?? 0,
                widget.offsetY ?? 0), // changes position of shadow
          ),
        ],
        color: widget.backgroundColor ?? Colors.transparent,
      ),
      child: Text(
        widget.label!,
        style: TextStyle(
          color: widget.fontColor ?? Colors.black,
          fontSize: widget.fontSize ?? 12,
          fontFamily: widget.fontFamily ?? 'Montserrat',
          fontWeight: widget.fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }

  Widget withWidthAndHeight(double width, double height) {
    return Container(
      height: width,
      width: height,
      padding: widget.paddingAll != null
          ? EdgeInsets.all(widget.paddingAll!)
          : EdgeInsets.only(
              top: widget.paddingTop ?? 0,
              bottom: widget.paddingBottom ?? 0,
              left: widget.paddingLeft ?? 0,
              right: widget.paddingRight ?? 0),
      margin: widget.marginAll != null
          ? EdgeInsets.all(widget.marginAll!)
          : EdgeInsets.only(
              top: widget.marginTop ?? 0,
              bottom: widget.marginBottom ?? 0,
              left: widget.marginLeft ?? 0,
              right: widget.marginRight ?? 0),
      alignment: widget.alignment ?? Alignment.center,
      decoration: BoxDecoration(
        borderRadius: widget.radiusAll != null
            ? BorderRadius.all(Radius.circular(widget.radiusAll ?? 0))
            : BorderRadius.only(
                topLeft: Radius.circular(widget.radiusTopLeft ?? 0),
                topRight: Radius.circular(widget.radiusTopRight ?? 0),
                bottomLeft: Radius.circular(widget.radiusBottomLeft ?? 0),
                bottomRight: Radius.circular(widget.radiusBottomRight ?? 0)),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor ?? Colors.transparent,
            spreadRadius: widget.spreadRadius ?? 0,
            blurRadius: widget.blurRadius ?? 0,
            offset: Offset(widget.offsetX ?? 0,
                widget.offsetY ?? 0), // changes position of shadow
          ),
        ],
        color: widget.backgroundColor ?? Colors.transparent,
      ),
      child: Text(
        widget.label!,
        style: TextStyle(
          color: widget.fontColor ?? Colors.black,
          fontSize: widget.fontSize ?? 12,
          fontFamily: widget.fontFamily ?? 'Montserrat',
          fontWeight: widget.fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }

  Widget container() {
    return Container(
      padding: widget.paddingAll != null
          ? EdgeInsets.all(widget.paddingAll!)
          : EdgeInsets.only(
              top: widget.paddingTop ?? 0,
              bottom: widget.paddingBottom ?? 0,
              left: widget.paddingLeft ?? 0,
              right: widget.paddingRight ?? 0),
      margin: widget.marginAll != null
          ? EdgeInsets.all(widget.marginAll!)
          : EdgeInsets.only(
              top: widget.marginTop ?? 0,
              bottom: widget.marginBottom ?? 0,
              left: widget.marginLeft ?? 0,
              right: widget.marginRight ?? 0),
      alignment: widget.alignment ?? Alignment.center,
      decoration: BoxDecoration(
        borderRadius: widget.radiusAll != null
            ? BorderRadius.all(Radius.circular(widget.radiusAll ?? 0))
            : BorderRadius.only(
                topLeft: Radius.circular(widget.radiusTopLeft ?? 0),
                topRight: Radius.circular(widget.radiusTopRight ?? 0),
                bottomLeft: Radius.circular(widget.radiusBottomLeft ?? 0),
                bottomRight: Radius.circular(widget.radiusBottomRight ?? 0)),
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor ?? Colors.transparent,
            spreadRadius: widget.spreadRadius ?? 0,
            blurRadius: widget.blurRadius ?? 0,
            offset: Offset(widget.offsetX ?? 0,
                widget.offsetY ?? 0), // changes position of shadow
          ),
        ],
        color: widget.backgroundColor ?? Colors.transparent,
      ),
      child: Text(
        widget.label!,
        style: TextStyle(
          color: widget.fontColor ?? Colors.black,
          fontSize: widget.fontSize ?? 12,
          fontFamily: widget.fontFamily ?? 'Montserrat',
          fontWeight: widget.fontWeight ?? FontWeight.normal,
        ),
      ),
    );
  }
}
