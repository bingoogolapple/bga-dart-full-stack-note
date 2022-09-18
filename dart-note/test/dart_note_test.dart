import 'package:bga_dart_note/bga_dart_note.dart';
import 'package:test/test.dart';

/**
 * https://pub.dartlang.org/packages/test
 *
 * 执行先后顺序和名称没关系，写得越靠前越先执行
 * 选中组时执行组内的所有单元测试
 * 选中某一个时执行单个测试
 * 既不选中组也不选中某个单元测试时，执行当前文件中的所有单元测试
 */
void main() {
  // 在当前文件单元测试执行前执行
  setUpAll(() {
    print('Test setUpAll');
  });

  // 在当前文件单元测试执行（即使执行失败）后执行
  tearDownAll(() {
    print('Test tearDownAll');
  });

  group('TestA', () {
    Person person;

    // 在每个单元测试执行前都会执行
    setUp(() {
      person = Person('BGA');
      print('TestA setUp');
    });

    // 在每个单元测试执行（即使执行失败）后都会执行
    tearDown(() {
      print('TestA tearDown');
    });

    // 在该组单元测试执行前执行
    setUpAll(() {
      print('TestA setUpAll');
    });

    // 在该组单元测试执行（即使执行失败）后执行
    tearDownAll(() {
      print('TestA tearDownAll');
    });

    test('TestA1', () {
      print('TestA1');
      expect(person.age == 27, isTrue);
    });

    test('TestA2', () {
      print('TestA2');
    });
  });

  group('TestB', () {
    setUp(() {
      print('TestB setUp');
    });

    tearDown(() {
      print('TestB tearDown');
    });

    setUpAll(() {
      print('TestB setUpAll');
    });

    tearDownAll(() {
      print('TestB tearDownAll');
    });

    test('TestB1', () {
      print('TestB1');
    });

    test('TestB2', () {
      print('TestB2');
    });
  });
}
