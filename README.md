# Floor Calculator

[![Language: Dart](https://img.shields.io/badge/Language-Dart-0175C2)](https://github.com/kleberandrade/floor-calculator-flutter/blob/master/pubspec.yaml)
[![Framework: Flutter](https://img.shields.io/badge/Framework-Flutter-02569B)](https://github.com/kleberandrade/floor-calculator-flutter/blob/master/pubspec.yaml)

Flutter classroom app for calculating floor and wall-covering quantities.

## Getting started

- Select a Flutter release whose bundled Dart SDK satisfies the manifest constraint, then run the commands below from the repository root.

```sh
flutter pub get
flutter run
```

- If the app depends on Firebase or another external service, configure your own service project using the dependencies and original notes; credentials are not supplied by this guide.

## Recorded requirements

- Dart SDK constraint from [`pubspec.yaml`](https://github.com/kleberandrade/floor-calculator-flutter/blob/master/pubspec.yaml): `>=2.7.0 <3.0.0`.

## Repository map

- [lib](https://github.com/kleberandrade/floor-calculator-flutter/tree/master/lib)
- [test](https://github.com/kleberandrade/floor-calculator-flutter/tree/master/test)
- [android](https://github.com/kleberandrade/floor-calculator-flutter/tree/master/android)
- [ios](https://github.com/kleberandrade/floor-calculator-flutter/tree/master/ios)

## Validation status

This update documents the tracked source and project metadata. It does not certify a successful build, device test or compatibility with a current toolchain. Follow any project-specific validation instructions in the original material.

## License and attribution

No standalone repository-wide license file was identified in this review. Preserve the original credits and any component-specific licenses; this documentation update grants no additional rights.

---

## Original project material

# Calculadora de pisos e revestimentos

Aplicativo de uma calculadora de pisos e revestimentos criado para disciplina de Programação Mobile, criado por Kleber de Oliveira Andrade

Tutorial de criação deste app: [clique aqui](https://medium.com/@kleberandrade/criando-um-aplicativo-em-flutter-para-calcular-a-quantidade-de-pisos-por-m%C2%B2-dac30b5b5027)

<p align="center">
    <img src="https://cdn-images-1.medium.com/max/400/1*-bDQqIcOqyc5-4qvQLBODQ.png" width="250"/>
    <img src="https://cdn-images-1.medium.com/max/400/1*AcNqHgMroIwf2y7XAZHoGQ.png" width="250"/>
    <img src="https://cdn-images-1.medium.com/max/400/1*B8I5SuZlGanHB8POBmBIZA.png" width="250"/>
</p>

## Como clonar o projeto

*   Faça um fork do projeto (precisa ter uma conta no github)
*   Abra o terminal do Visual Studio Code
*   Acesse a pasta onde deseja salvar o aplicativo e digite: git clone *link_do_projeto_no_seu_github* **floor_calculator**
*   Clique em File --> Open e abra o projeto
*   Não se esqueça de abrir o arquivo *pubspec.yaml* e salvar (CTRL + S) o arquivo para que os plugins sejam baixados 

## Desafio para aula

*   [ ] Adicionar um novo atributo (price) na classe FloorModel e um novo campo numérico no CalculatorPage para o usuário digitar o preço;
*   [ ] Criar uma função para calcular o preço na classe Controller e exibir o resultado no ResultDialog;
*   [ ] Validar os campos de entrada para quando o usuário digitar valores negativos ou zero;
*   [ ] Criar uma função para limpar (zerar) os campos do formulário;
*   [ ] Criar um ícone para o aplicativo ([plugin flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons), [gerador de ícone](https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html). Exemplo de como inserir imagens no flutter, [clique aqui](https://medium.com/@suragch/how-to-include-images-in-your-flutter-app-863889fc0b29).

## Licença

    Copyright 2020 Kleber de Oliveira Andrade
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
