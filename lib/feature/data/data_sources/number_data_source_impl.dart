import 'package:injectable/injectable.dart';
import 'package:number_to_text_converter/feature/data/data_sources/number_data_source.dart';

@Singleton(as: NumberDataSource)
class NumberDataSourceImpl implements NumberDataSource {
  @override
  Future<Map<int, String>> getGroupMap() async {
    return await groupWord;
  }

  @override
  Future<Map<int, String>> getNumberMap() async {
    return await numberWord;
  }

  final Map<int, String> numberWord = {
    1: "One",
    2: "Two",
    3: "Three",
    4: "Four",
    5: "Five",
    6: "Six",
    7: "Seven",
    8: "Eight",
    9: "Nine",
    10: "Ten",
    11: "Eleven",
    12: "Twelve",
    13: "Thirteen",
    15: "Fifteen",
    18: "Eighteen",
    20: "Twenty",
    30: "Thirty",
    40: "Forty",
    50: "Fifty",
    80: "Eighty"
  };

  final Map<int, String> groupWord = {
    2: "Thousand",
    3: "Million",
    4: "Billion",
    5: "Trillion",
    6: "Quadrillion",
    7: "Quintillion",
    8: "Sextillion"
  };
}
