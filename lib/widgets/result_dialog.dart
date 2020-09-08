import 'package:flutter/material.dart';

import 'package:floor_calculator/models/result_model.dart';

class ResultDialog extends StatelessWidget {
  final ResultModel result;

  const ResultDialog(this.result);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Resultado'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildResultLine(
            context,
            'Quantidade de pisos',
            '${result.amountPieces} pisos',
          ),
          SizedBox(height: 10),
          _buildResultLine(
            context,
            'Quantidade de pisos para o rodapé',
            '${result.amountFooter} pisos',
          ),
          SizedBox(height: 10),
          _buildResultLine(
            context,
            'Total de pisos',
            '${result.amountPieces + result.amountFooter} pisos',
          ),
          Divider(),
          _buildResultLine(
            context,
            'Metragem quadrada total sem rodapé',
            '${result.amountPieces * result.areaFloor} m²',
          ),
          SizedBox(height: 10),
          _buildResultLine(
            context,
            'Metragem quadrada total com rodapé',
            '${(result.amountPieces + result.amountFooter) * result.areaFloor} m²',
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          textColor: Theme.of(context).primaryColor,
          child: const Text('CONTINUAR'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  _buildResultLine(context, label, result) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          result,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
