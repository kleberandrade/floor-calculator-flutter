import 'package:floor_calculator/controllers/calculator_controller.dart';
import 'package:floor_calculator/dialogs/result_dialog.dart';
import 'package:floor_calculator/helpers/validator_helper.dart';
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
      appBar: AppBar(title: Text('Calculator Page')),
      body: SingleChildScrollView(
        child: Container(
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
          SizedBox(height: 20),
          _buildNumberInputField('Largura', onSaved: _controller.setRoomWidth),
          SizedBox(height: 20),
          _buildNumberInputField('Comprimento',
              onSaved: _controller.setRoomLength),
          SizedBox(height: 20),
          _buildHeaderText('Dimensões do piso'),
          SizedBox(height: 20),
          _buildNumberInputField('Largura (metros)',
              onSaved: _controller.setFloorWidth),
          SizedBox(height: 20),
          _buildNumberInputField('Comprimento (metros)',
              onSaved: _controller.setFloorLength),
          SizedBox(height: 20),
          _buildHeaderText('Preço do piso'),
          SizedBox(height: 20),
          _buildNumberInputField('Preço por peça',
              onSaved: _controller.setFloorPrice),
          SizedBox(height: 40),
          _buildCalculatorButton(),
          SizedBox(height: 10),
          _buildClearButton(),
        ],
      ),
    );
  }

  _buildHeaderText(String label) {
    return Container(
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
        child: Center(child: Text(label)));
  }

  _buildNumberInputField(String label, {Function(String) onSaved}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: onSaved,
      validator: ValidatorHelper.isEmptyOrNegative,
      decoration: InputDecoration(
        labelText: label,
        border: OutLineInputBorder(),
      ),
    );
  }

  _buildCalculatorButton() {
    return RaisedButton(
      child: Text('Calcular'),
      onPressed: _calculate,> ResultDialog(result),
    );
  }

  _buildClearButton() {
    return RaisedButton(
      onPressed: _clear,
      child: Text('Limpar'),
    ):  
}

  void _clear() => _formKey.currentState.reset();

  void _calculate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final result = _controller.calculate();
      showDialog(
        context: context,
        builder: (context) => ResultDialog(result),
      );
    }     
  }
}  