import 'package:wallet_wise/core/app_export.dart';

enum IncomeType {
  none,
  business,
  salary,
  dividends,
  investment,
  rent,
  freelance,
  royalty,
  passive,
}

enum ExpenseType {
  none,
  procurement,
  food,
  transport,
  rest,
  investment,
}

class WalletModel {
  double totalBalance;
  List<WalletChangeData> incomesData;
  List<WalletChangeData> expensesData;

  WalletModel({
    required this.totalBalance,
    required this.incomesData,
    required this.expensesData,
  });

  // Метод для сериализации в JSON
  Map<String, dynamic> toJson() {
    return {
      'totalBalance': totalBalance,
      'incomesData': incomesData.map((data) => data.toJson()).toList(),
      'expensesData': expensesData.map((data) => data.toJson()).toList(),
    };
  }

  // Метод для десериализации из JSON
  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      totalBalance: json['totalBalance'],
      incomesData: (json['incomesData'] as List)
          .map((data) => WalletChangeData.fromJson(data))
          .toList(),
      expensesData: (json['expensesData'] as List)
          .map((data) => WalletChangeData.fromJson(data))
          .toList(),
    );
  }
}

class WalletChangeData {
  double changeValue;
  IncomeType incomeType;
  ExpenseType expenseType;
  DateTime dateTime;

  WalletChangeData({
    required this.changeValue,
    this.incomeType = IncomeType.none,
    this.expenseType = ExpenseType.none,
    required this.dateTime,
  });

  // Метод для сериализации в JSON
  Map<String, dynamic> toJson() {
    return {
      'changeValue': changeValue,
      'incomeType':
          incomeType.toString().split('.').last, // Преобразование в строку
      'expenseType':
          expenseType.toString().split('.').last, // Преобразование в строку
      'dateTime': dateTime.toIso8601String(),
    };
  }

  // Метод для десериализации из JSON
  factory WalletChangeData.fromJson(Map<String, dynamic> json) {
    return WalletChangeData(
      changeValue: json['changeValue'],
      incomeType: IncomeType.values.firstWhere(
          (e) => e.toString().split('.').last == json['incomeType']),
      expenseType: ExpenseType.values.firstWhere(
          (e) => e.toString().split('.').last == json['expenseType']),
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}

class WalletChangeDataParser {
  static String getTitle(WalletChangeData data) {
    if (data.incomeType != IncomeType.none) {
      return getIncomeTitle(data.incomeType);
    } else if (data.expenseType != ExpenseType.none) {
      return getExpenseTitle(data.expenseType);
    } else {
      return "Unknown";
    }
  }

  static bool getIsIncome(WalletChangeData data) {
    if (data.incomeType != IncomeType.none) {
      return true;
    } else {
      return false;
    }
  }

  static String getImageUrl(WalletChangeData data) {
    if (data.incomeType != IncomeType.none) {
      return getIncomeImageUrl(data.incomeType);
    } else if (data.expenseType != ExpenseType.none) {
      return getExpenseImageUrl(data.expenseType);
    } else {
      return "path_to_default_image";
    }
  }

  static String getIncomeTitle(IncomeType type) {
    switch (type) {
      case IncomeType.business:
        return "Business";
      case IncomeType.salary:
        return "Salary";
      case IncomeType.dividends:
        return "Dividends";
      case IncomeType.investment:
        return "Investment";
      case IncomeType.rent:
        return "Rent";
      case IncomeType.freelance:
        return "Freelance";
      case IncomeType.royalty:
        return "Royalty";
      case IncomeType.passive:
        return "Passive Income";
      default:
        return "None";
    }
  }

  static String getExpenseTitle(ExpenseType type) {
    switch (type) {
      case ExpenseType.procurement:
        return "Procurement";
      case ExpenseType.food:
        return "Food";
      case ExpenseType.transport:
        return "Transport";
      case ExpenseType.rest:
        return "Rest";
      case ExpenseType.investment:
        return "Investment";
      default:
        return "None";
    }
  }

  static String getIncomeImageUrl(IncomeType type) {
    switch (type) {
      case IncomeType.business:
        return ImageConstant.imgBusiness;
      case IncomeType.salary:
        return ImageConstant.imgSalary;
      case IncomeType.dividends:
        return ImageConstant.imgDividends;
      case IncomeType.investment:
        return ImageConstant.imgInvestmentIncome;
      case IncomeType.rent:
        return ImageConstant.imgRent;
      case IncomeType.freelance:
        return ImageConstant.imgFreelance;
      case IncomeType.royalty:
        return ImageConstant.imgRoyalty;
      case IncomeType.passive:
        return ImageConstant.imgPassive;
      default:
        return ImageConstant.imgSalary;
    }
  }

  static String getExpenseImageUrl(ExpenseType type) {
    switch (type) {
      case ExpenseType.procurement:
        return ImageConstant.imgProcurement;
      case ExpenseType.food:
        return ImageConstant.imgFood;
      case ExpenseType.transport:
        return ImageConstant.imgTransport;
      case ExpenseType.rest:
        return ImageConstant.imgRest;
      case ExpenseType.investment:
        return ImageConstant.imgInvestmentExpense;
      default:
        return "assets/images/expense_none.png";
    }
  }
}
