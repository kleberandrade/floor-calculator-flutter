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

## Stack

- **Flutter 3.41+** com Dart 3, null-safety, Material 3
- **flutter_riverpod** para estado (ChangeNotifierProvider + StateProvider)
- **go_router** para navegação declarativa entre `/` e `/result`
- **lucid_validation** para validação de formulários
- **toastification** para feedback ao usuário
- **flutter_localizations + intl** para internacionalização (pt, en, es)
- **google_mobile_ads** para banner AdMob (IDs de teste por padrão)
- **alchemist** para testes de regressão visual (golden tests)

## Idiomas e tema

- Três idiomas: **Português (BR)**, **Inglês**, **Espanhol** — alternáveis no menu de configurações (ícone de engrenagem)
- Três modos de tema: **Claro**, **Escuro**, **Seguir sistema**

## Anúncios (AdMob)

O app usa o pacote `google_mobile_ads` com IDs de teste oficiais do Google em
[android/app/src/main/AndroidManifest.xml](android/app/src/main/AndroidManifest.xml) e
[lib/widgets/banner_ad_widget.dart](lib/widgets/banner_ad_widget.dart). Para publicar em
produção, substitua pelos IDs reais da sua conta AdMob:

- `AdMobIds.bannerUnitId` (Android e iOS)
- `com.google.android.gms.ads.APPLICATION_ID` no AndroidManifest.xml

No iOS é preciso adicionar `GADApplicationIdentifier` no `Info.plist`.

## Testes

| Tipo | Pasta | Comando |
|---|---|---|
| Unitário (controller, validations, parse) | `test/unit/` | `flutter test test/unit/` |
| Smoke (app inicia) | `test/smoke/` | `flutter test test/smoke/` |
| Widget (interações da UI) | `test/widget/` | `flutter test test/widget/` |
| Golden (regressão visual em light/dark × pt/en/es) | `test/golden/` | `flutter test test/golden/` |
| E2E (integration_test) | `integration_test/` | `flutter test integration_test/ -d <device>` |

Regenerar as imagens golden após mudanças de UI intencionais:
```
flutter test test/golden/ --update-goldens
```

## Funcionalidades

*   Cálculo da quantidade de pisos para o chão e para o rodapé
*   Cálculo da metragem quadrada com e sem rodapé
*   **Custo total da obra** — preço por caixa e pisos por caixa, mostrando o número de caixas necessárias e o valor total
*   **Margem de perda configurável (0% a 30%)** — aplica perda adicional aos pisos calculados, prática comum em obras
*   **Múltiplos cômodos** — adicione vários cômodos com nome (Sala, Quarto, Cozinha, etc.) e veja o detalhamento por cômodo e o total agregado
*   **Compartilhamento do orçamento** — botão para mandar o resumo via WhatsApp, e-mail ou outros apps
*   Validação de valores negativos ou zero
*   Botão para limpar (zerar) o formulário

## Desafio para aula

*   [x] Adicionar um novo atributo (price) na classe FloorModel e um novo campo numérico no CalculatorPage para o usuário digitar o preço
*   [x] Criar uma função para calcular o preço na classe Controller e exibir o resultado no ResultDialog
*   [x] Validar os campos de entrada para quando o usuário digitar valores negativos ou zero
*   [x] Criar uma função para limpar (zerar) os campos do formulário
*   [ ] Criar um ícone para o aplicativo ([plugin flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons), [gerador de ícone](https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html). Exemplo de como inserir imagens no flutter, [clique aqui](https://medium.com/@suragch/how-to-include-images-in-your-flutter-app-863889fc0b29))
*   [ ] Adicionar cálculo automático de argamassa colante (AC-II) e rejunte (kg) com base na metragem
*   [ ] Persistir orçamentos antigos com `shared_preferences` ou `sqflite`
*   [ ] Suportar cômodos não-retangulares (em "L") ou com recortes (portas, pilares)

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
