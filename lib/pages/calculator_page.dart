import 'package:floor_calculator/conrtollers/calculator_controller.dart';
import 'package:floor_calculator/helpers/validator.dart';
import 'package:floor_calculator/widgets/result_dialog.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = CalculatorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de pisos'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: _buildForm(),
        ),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderText('Dimensões do cômodo'),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Largura (metros)',
            onSaved: _controller.setRoomWidth,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Comprimento (metros)',
            onSaved: _controller.setRoomLength,
          ),
          _buildVerticalSpace(),
          _buildHeaderText('Dimensões do piso'),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Largura (centimetros)',
            onSaved: _controller.setFloorWidth,
          ),
          _buildVerticalSpace(),
          _buildNumberInputField(
            'Comprimento (centimetros)',
            onSaved: _controller.setFloorLength,
          ),
          _buildVerticalSpace(height: 40),
          _buildCalculateButton(),
        ],
      ),
    );
  }

  _buildVerticalSpace({double height = 20}) {
    return SizedBox(height: height);
  }

  _buildHeaderText(String title) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor.withOpacity(0.1),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _buildNumberInputField(String label, {Function(String) onSaved}) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
      validator: Validator.isEmptyText,
      keyboardType: TextInputType.number,
      onSaved: onSaved,
    );
  }

  _buildCalculateButton() {
    return RaisedButton(
      child: Text('CALCULAR'),
      onPressed: _calculate,
    );
  }

  _calculate() {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      final result = _controller.calculate();
      showDialog(
        context: context,
        builder: (context) => ResultDialog(result),
      );
    }
  }
}
