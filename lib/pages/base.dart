import 'package:Applaudio/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Base<T extends Model> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T> _builder;
  final Function(T) onModelReady;

  Base({ScopedModelDescendantBuilder<T> builder, this.onModelReady}) : _builder = builder;

  @override
  _Base<T> createState() => _Base<T>();
}

class _Base<T extends Model>  extends State<Base<T>> {

  T _model = locator<T>();

  @override
  void initState() {
    if(widget.onModelReady != null){
      widget.onModelReady(_model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<T>(
        model: _model,
        child: ScopedModelDescendant<T>(
          builder: widget._builder,
        ));
  }
}
