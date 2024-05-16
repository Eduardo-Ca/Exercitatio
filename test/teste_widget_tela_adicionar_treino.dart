import 'package:mockito/mockito.dart';
import 'package:exercitatio/core/components/botao_component.dart';
import 'package:exercitatio/core/components/contador_component.dart';
import 'package:exercitatio/core/components/text_field_component.dart';
import 'package:exercitatio/core/data/database.dart';
import 'package:exercitatio/module/treinos/presenter/adicionar_treino_tela.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AdicionarTreinoTela', () {
    late MockDatabaseHelper mockDatabaseHelper;
    late MockImagePicker mockImagePicker;

    setUp(() {
      mockDatabaseHelper = MockDatabaseHelper();
      mockImagePicker = MockImagePicker();
    });
    testWidgets('Deve exibir widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AdicionarTreinoTela(diaSemana: 'Segunda-feira'),
        ),
      );
      await tester.pumpAndSettle();

      try {
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byType(InkWell), findsOneWidget);
      } catch (e) {
        // print('Erro ao achar widgets: $e');
        rethrow;
      }
    });

    testWidgets('deve pegar uma imagem da galeria',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AdicionarTreinoTela(diaSemana: 'Segunda-feira'),
        ),
      );

      try {
        final pickedFile = XFile('test/path/image.jpg');
        when(mockImagePicker.pickImage(source: ImageSource.gallery))
            .thenAnswer((_) async => pickedFile);

        await tester.tap(find.byType(InkWell));
        await tester.pumpAndSettle();

        expect(find.byType(Image), findsOneWidget);
      } catch (e) {
        //print('Erro ao pegar imagem da galeria: $e');
        rethrow;
      }
    });

    testWidgets('deve salvar o treino', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AdicionarTreinoTela(diaSemana: 'Segunda-feira'),
        ),
      );

      try {
        await tester.enterText(find.byType(TextField).at(0), 'Treino A');
        await tester.enterText(find.byType(TextField).at(1), 'Descrição A');
        await tester.enterText(find.byType(TextField).at(2), '3');
        await tester.enterText(find.byType(TextField).at(3), '10');

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();
      } catch (e) {
        // print('Erro ao salvar treino: $e');
        rethrow;
      }
    });
  });
}
