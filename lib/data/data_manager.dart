import 'package:intl/intl.dart';
import 'package:wallet_wise/data/shared_preference_service.dart';

import '../core/app_export.dart';
import 'models/news_model/news_model.dart';
import 'models/wallet_model/wallet_model.dart';

class DataManager {
  static final String _key = 'analysis_model';
  static WalletModel data =
      WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

  static Future<void> addOrUpdateWallet(WalletModel inputData) async {
    data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Check if the data is not equal to inputData
    if (data != inputData) {
      // Update existing item
      data = inputData;
      await SharedPreferencesService.saveLoanOutputDataList(data);
    }
  }

  static Future<List<WalletModel>> getWallet() async {
    data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);
    return [data];
  }

  static Future<void> addToIncomeList(WalletChangeData newIncome) async {
    // Get the current data from SharedPreferences
    data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Add the new income to the list
    data.incomesData.add(newIncome);
    // Update the total balance
    updateTotalBalance();

    // Update and save the data
    await SharedPreferencesService.saveLoanOutputDataList(data);
  }

  static Future<void> addToExpensesList(WalletChangeData newExpense) async {
    // Get the current data from SharedPreferences
    data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Add the new expense to the list
    data.expensesData.add(newExpense);
    // Update the total balance
    updateTotalBalance();

    // Update and save the data
    await SharedPreferencesService.saveLoanOutputDataList(data);
  }

  static Future<List<WalletChangeData>> getIncomeList() async {
    // Получаем текущие данные из SharedPreferences
    WalletModel data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Возвращаем список доходов
    return data.incomesData;
  }

  static Future<List<WalletChangeData>> getExpenseList() async {
    // Получаем текущие данные из SharedPreferences
    WalletModel data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Возвращаем список расходов
    return data.expensesData;
  }

  static Future<List<WalletChangeData>> getAllTransactionsSortedByDate() async {
    // Получаем текущие данные из SharedPreferences
    WalletModel data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Объединяем доходы и расходы в один список
    List<WalletChangeData> allTransactions = []
      ..addAll(data.incomesData)
      ..addAll(data.expensesData);

    // Сортируем список по дате
    allTransactions.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return allTransactions;
  }

  static Future<double> getTotalBalance() async {
    // Get the current data from SharedPreferences
    data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Calculate the total balance
    double totalIncome = data.incomesData
        .map((income) => income.changeValue)
        .fold(0, (sum, amount) => sum + amount);

    double totalExpense = data.expensesData
        .map((expense) => expense.changeValue)
        .fold(0, (sum, amount) => sum + amount);

    return data.totalBalance +
        await getTotalExpenses() +
        await getTotalExpenses();
  }

  static Future<double> getTotalIncomes() async {
    // Get the current data from SharedPreferences
    data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Calculate the total balance
    double totalIncome = data.incomesData
        .map((income) => income.changeValue)
        .fold(0, (sum, amount) => sum + amount);

    return totalIncome;
  }

  static Future<double> getTotalExpenses() async {
    // Get the current data from SharedPreferences
    data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Calculate the total balance
    double totalExpense = data.expensesData
        .map((expense) => expense.changeValue)
        .fold(0, (sum, amount) => sum + amount);

    return totalExpense;
  }

  static void updateTotalBalance() {
    // Calculate the total balance
    double totalIncome = data.incomesData
        .map((income) => income.changeValue)
        .fold(0, (sum, amount) => sum + amount);

    double totalExpense = data.expensesData
        .map((expense) => expense.changeValue)
        .fold(0, (sum, amount) => sum + amount);

    // Update the total balance in the data
    data.totalBalance = totalIncome - totalExpense;
  }

  static Future<Map<String, double>> getDailyBalance() async {
    final transactions = await getAllTransactionsSortedByDate();
    final today = DateTime.now();

    Map<String, double> dailyBalance = {DateFormat('E').format(today): 0.0};

    for (var transaction in transactions) {
      if (transaction.dateTime.isSameDate(today)) {
        dailyBalance[DateFormat('E').format(today)] =
            (dailyBalance[DateFormat('E').format(today)] ?? 0) +
                transaction.changeValue;
      }
    }

    return dailyBalance;
  }

  static Future<Map<String, double>> getWeeklyBalance() async {
    final transactions = await getAllTransactionsSortedByDate();
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    Map<String, double> weeklyBalance = {
      'Mon': 0.0,
      'Tue': 0.0,
      'Wed': 0.0,
      'Thu': 0.0,
      'Fri': 0.0,
      'Sat': 0.0,
      'Sun': 0.0
    };

    for (var transaction in transactions) {
      if (transaction.dateTime.isAfter(startOfWeek) &&
          transaction.dateTime.isBefore(startOfWeek.add(Duration(days: 7)))) {
        final day = DateFormat('E').format(transaction.dateTime);
        weeklyBalance[day] =
            (weeklyBalance[day] ?? 0) + transaction.changeValue;
      }
    }

    return weeklyBalance;
  }

  static Future<Map<String, double>> getMonthlyBalance() async {
    final transactions = await getAllTransactionsSortedByDate();
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    Map<String, double> monthlyBalance = {
      'W1': 0.0,
      'W2': 0.0,
      'W3': 0.0,
      'W4': 0.0,
      'W5': 0.0
    };

    for (var transaction in transactions) {
      if (transaction.dateTime.isAfter(startOfMonth) &&
          transaction.dateTime.isBefore(startOfMonth.add(Duration(days: 31)))) {
        final weekOfMonth = (transaction.dateTime.day / 7).ceil();
        final weekLabel = 'W$weekOfMonth';
        monthlyBalance[weekLabel] =
            (monthlyBalance[weekLabel] ?? 0) + transaction.changeValue;
      }
    }

    return monthlyBalance;
  }

  static Future<double> getTotalIncomesByType(IncomeType type) async {
    // Get the current data from SharedPreferences
    data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Calculate the total income by type
    double totalIncome = data.incomesData
        .where((income) => income.incomeType == type)
        .map((income) => income.changeValue)
        .fold(0, (sum, amount) => sum + amount);

    return totalIncome;
  }

  static Future<double> getTotalExpensesByType(ExpenseType type) async {
    // Get the current data from SharedPreferences
    data = await SharedPreferencesService.getLoanOutputDataList() ??
        WalletModel(totalBalance: 0, incomesData: [], expensesData: []);

    // Calculate the total expense by type
    double totalExpense = data.expensesData
        .where((expense) => expense.expenseType == type)
        .map((expense) => expense.changeValue)
        .fold(0, (sum, amount) => sum + amount);

    return totalExpense;
  }

  static List<NewsModel> getAllNews() {
    List<NewsModel> news = [
      NewsModel(
        dateTime: DateTime.now(),
        imgUrl: ImageConstant.imgNews1,
        title:
            'Partnership with financial institutions to expand services',
        body:
            'Partnership with financial institutions is an important strategic step for expanding the range of services of a company and increasing its competitiveness in the market. Such partnerships enable the creation of mutually beneficial relationships that contribute to enhancing customer satisfaction and expanding the customer base.\n\nPartnering with financial institutions allows your company to offer customers additional financial services such as loans, investments, insurance, etc., without having its own financial products. This helps meet diverse customer needs and become a more attractive partner for them.\n\nCollaboration with financial institutions opens up new opportunities for your business in various markets. Partnership allows penetration into markets where financial institutions already have an established customer base, leading to increased sales volume and profit growth.\n\nCollaborating with large and reputable financial institutions can enhance your company\'s reputation and increase customer trust. Customers, upon seeing your company partnering with an authoritative financial institution, may feel more confident in choosing your services.\n\nExchange of experience and resources. Collaboration with financial institutions enables the exchange of experience, knowledge, and resources, promoting professionalism and efficiency for both parties. This exchange can lead to the creation of new innovative products and services, enriching the portfolios of both companies.\n\nOverall, partnering with financial institutions is a strategically important decision that allows your company to expand its capabilities, ensure sustainable growth, and overcome competition in the market.',
        author: 'Desmond Kane',
      ),
      NewsModel(
        dateTime: DateTime.now(),
        imgUrl: ImageConstant.imgNews2,
        title:
            'Increase in interest rates on deposits for clients',
        body:
            'Increasing the interest rate on deposits for clients is one of the mechanisms that banks and financial institutions can utilize to attract funds from customers and manage their liquidity. Raising interest rates on deposits can attract new clients who seek higher profitability on their savings. Higher rates can incentivize customers to choose your bank to store their funds.\n\nRaising interest rates on deposits can also help retain current clients. Upon learning about more favorable conditions at your bank, clients may decide to keep their savings with you instead of switching to competitors.\n\nLiquidity management. Increasing interest rates on deposits can be used to attract additional funds to the bank for liquidity management purposes. This contributes to a more stable position for the bank in conditions of market volatility and ensures an adequate level of reserves.\n\nRaising interest rates on deposits can also stimulate demand for other financial products offered by the bank. For instance, clients who place deposits at increased rates may show interest in investment products or other services, thus enhancing the diversity of the bank\'s portfolio.\n\nRaising interest rates on deposits can provide a bank with a competitive advantage in the market, helping to attract the attention of potential clients and stand out among other financial institutions offering similar services.\n\nHowever, it is important to remember that increasing interest rates on deposits should be justified by financial and economic factors to avoid causing imbalance in the bank\'s operations. This strategic decision should align with the overall bank strategy and contribute to its sustainable development.',
        author: 'Desmond Kane',
      ),
      NewsModel(
        dateTime: DateTime.now(),
        imgUrl: ImageConstant.imgNews3,
        title:
            'Stocks are rising, the dollar is strengthening, experts forecast new records.',
        body:
            'In the recent days, financial markets are coming alive again, showing vivid activity and attracting increased interest from investors and analysts worldwide. Stocks of various companies and indices are rapidly growing, creating a favorable atmosphere in the securities market. This upward trend is supported not only by internal company factors but also by external economic conditions that contribute to overall optimism.\n\nSimultaneously with the rise in stocks, there is an observed strengthening of the dollar against other global currencies. This phenomenon is driven by multiple factors, including the stable economic development of the USA, trust in the American currency as a risk-free asset, as well as changes in global politics and trade that shape the demand and supply for the dollar.\n\nExperts, monitoring global markets and analyzing current events, express confidence that financial markets are poised to set new historical records. Their forecasts are based on the steady growth of stocks, the strengthening of the dollar, and the overall positive sentiment in the global economy. Experts highlight strategic investment opportunities, emphasizing prospects for investors willing to capitalize on current market conditions.\n\nOverall, the active movement in financial markets creates a favorable environment for investment and trading, offering unique opportunities for success on the global financial stage. It is important to remember that despite the positive trends, there is always a certain level of risk, and it is essential to consult advisors and experts to make informed financial decisions in the ever-changing world of investments',
        author: 'Desmond Kane',
      ),
      NewsModel(
        dateTime: DateTime.now(),
        imgUrl: ImageConstant.imgNews4,
        title:
            'Conducting operations with cryptocurrency',
        body:
            'The implementation of cryptocurrency operations is the process of integrating the ability to conduct financial transactions using cryptocurrency into various aspects of businesses and everyday life. This may involve developing special technological solutions, changes in legal norms, creating infrastructure for cryptocurrency exchange, as well as widespread training and informational support for individuals willing to explore this area.\n\nThe implementation of cryptocurrency operations can have several advantages. Firstly, it can reduce costs for transfers and cross-border transactions by eliminating intermediaries and minimizing fees. Additionally, cryptocurrencies allow for a higher degree of confidentiality and fund security, as well as simplifying the processes of accounting and tracking financial transactions.\n\nHowever, the implementation of cryptocurrency operations also comes with certain risks and challenges. In particular, the volatility of cryptocurrency prices, high technical security requirements, and complexities in regulating this area can pose significant obstacles to the widespread adoption of cryptocurrency operations.\n\nFor successful implementation of cryptocurrency operations, it is necessary to combine technological, legal, and educational aspects, ensuring reliability, security, and accessibility for users. Furthermore, it is essential to foster international cooperation to establish a common standard and rules in the field of cryptocurrency operations.',
        author: 'Desmond Kane',
      ),
      NewsModel(
        dateTime: DateTime.now(),
        imgUrl: ImageConstant.imgNews5,
        title:
            'Introduction of new technologies to ensure security',
        body:
            'The introduction of new technologies plays an important role in ensuring the security of financial transactions. With the development of cryptography, biometrics, machine learning, and blockchain, companies and financial institutions can provide a more reliable and secure environment for their clients.\n\nFor example, the implementation of biometric identification, such as fingerprint scanning or facial recognition, significantly enhances protection against unauthorized access to financial systems. The expanded use of blockchain technology can ensure transparency and reliability of financial transactions through a decentralized accounting system.\n\nMachine learning is used to analyze large volumes of data to detect anomalies and potential security threats. This allows for swift responses to possible attacks or fraudulent schemes.\n\nThus, the implementation of new technologies to ensure the security of financial transactions plays a crucial role in protecting the interests of clients and preventing financial crimes.',
        author: 'Desmond Kane',
      ),
      NewsModel(
        dateTime: DateTime.now(),
        imgUrl: ImageConstant.imgNews6,
        title:
            'Introduction of new credit products for entrepreneurs.',
        body:
            'Introducing new credit products for entrepreneurs is a strategically important decision for a credit organization aimed at meeting the needs of entrepreneurs and fostering the development of their businesses. It is also a way for banks to attract new clients and diversify their services.\n\nWhen introducing new credit products for entrepreneurs, a bank typically focuses on creating flexible and customized financial solutions that meet the unique needs of this client group. New products may include special financing programs for startups, expanded credit lines for businesses, funding for innovative projects, or even specialized services for specific industries.\n\nFurthermore, introducing new credit products for entrepreneurs may involve streamlining the loan application process, simplifying loan terms, and reducing barriers to accessing financing.\n\nThis strategy also includes training bank staff to better understand the realities and needs of entrepreneurial activities, as well as the ability to effectively advise business clients on financing and debt management issues.\n\nOverall, introducing new credit products for entrepreneurs contributes to the development of the business community, stimulates innovation, and promotes economic growth by providing entrepreneurs with more opportunities to realize their projects and initiatives.16:24',
        author: 'Desmond Kane',
      ),
    ];

    return news;
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
