import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyHomePageController extends GetxController {
  var taxExemption = 97000; //免稅扣除額
  var standardDeduction = 131000; //標準扣除額
  var payrollDeductions = 218000; //薪資扣除額

  var amountMan = 0; //薪資
  var dividendMan = 0; //股利

  var amountGirl = 0; //薪資
  var dividendGirl = 0;

  // 輸入框控制器
  final manSalaryController = TextEditingController();
  final manDividendController = TextEditingController();
  final womanSalaryController = TextEditingController();
  final womanDividendController = TextEditingController();

  var message = ''.obs;

  double checkAmountDoubleAllReduce(String allReduceWho, bool isDividend) {
    //各類分開合併
    if (allReduceWho == 'man') {
      var reduceManPayRoll =
          (amountMan - taxExemption - payrollDeductions + dividendMan);
      var reduceManPayRollTax = checkTax(reduceManPayRoll);

      if (isDividend) {
        var amountTotal = amountGirl;
        var dividendTotal = dividendMan + dividendGirl;

        var totalAmount = amountTotal +
            dividendGirl -
            (taxExemption + standardDeduction * 2 + payrollDeductions);

        var checkDividendTotalFee = (dividendTotal * (0.085) >= 80000)
            ? 80000
            : dividendTotal * (0.085); //股利分開扣除

        print("男生總額${reduceManPayRoll} 稅率${reduceManPayRollTax}");
        print("剩下總額${totalAmount} 稅率${checkTax(totalAmount)}");

        return (reduceManPayRoll * reduceManPayRollTax -
                checkProgressive(checkTax(reduceManPayRoll))) +
            totalAmount * (checkTax(totalAmount)) -
            checkProgressive(checkTax(totalAmount)) -
            checkDividendTotalFee;

        //男方薪資扣除部分扣除額 * 稅率  -累進稅率 + 剩下的薪資+股利 * 稅率 - 股利合併稅 - 累進稅率
      } else {
        var reduceManPayRoll = (amountMan - taxExemption - payrollDeductions);
        var reduceManPayRollTax = checkTax(reduceManPayRoll);

        var dividendTotal = dividendMan + dividendGirl;

        var totalAmount = amountGirl -
            (taxExemption + standardDeduction * 2 + payrollDeductions);

        var progressiveFee = checkProgressive(checkTax(totalAmount)); //累進稅率
        var checkDividendTotalFee = dividendTotal * 0.28;

        print("男生總額${reduceManPayRoll} 稅率${reduceManPayRollTax}");
        print("剩下總額${totalAmount} 稅率${checkTax(totalAmount)}");

        return (reduceManPayRoll * reduceManPayRollTax -
                checkProgressive(checkTax(reduceManPayRoll))) +
            totalAmount * (checkTax(totalAmount)) -
            progressiveFee +
            checkDividendTotalFee;
        // 男方薪資扣除部分扣除額 *稅率 - 累進 +
      }
    } else {
      var reduceGirlPayRoll =
          (amountGirl - taxExemption - payrollDeductions + dividendGirl);
      var reduceGirlPayRollTax = checkTax(reduceGirlPayRoll);

      if (isDividend) {
        var amountTotal = amountMan;
        var dividendTotal = dividendMan + dividendGirl;

        var totalAmount = amountTotal +
            dividendMan -
            (taxExemption + standardDeduction * 2 + payrollDeductions);

        var checkDividendTotalFee = (dividendTotal * (0.085) >= 80000)
            ? 80000
            : dividendTotal * (0.085); //股利分開扣除

        print("女生總額${reduceGirlPayRoll} 稅率${reduceGirlPayRollTax}");
        print("剩下總額${totalAmount} 稅率${(checkTax(totalAmount))}");

        return (reduceGirlPayRoll * reduceGirlPayRollTax -
                checkProgressive(checkTax(reduceGirlPayRoll))) +
            totalAmount * (checkTax(totalAmount)) -
            checkProgressive(checkTax(totalAmount)) -
            checkDividendTotalFee;

        //男方薪資扣除部分扣除額 * 稅率  -累進稅率 + 剩下的薪資+股利 * 稅率 - 股利合併稅 - 累進稅率
      } else {
        var reduceGirlPayRoll = (amountGirl - taxExemption - payrollDeductions);
        var reduceGirlPayRollTax = checkTax(reduceGirlPayRoll);

        var dividendTotal = dividendMan + dividendGirl;

        var totalAmount = amountMan -
            (taxExemption + standardDeduction * 2 + payrollDeductions);

        var progressiveFee = checkProgressive(checkTax(totalAmount)); //累進稅率
        var checkDividendTotalFee = dividendTotal * 0.28;

        print("女生總額${reduceGirlPayRoll} 稅率${reduceGirlPayRollTax}");
        print("剩下總額${totalAmount} 稅率${(checkTax(totalAmount))}");

        return (reduceGirlPayRoll * reduceGirlPayRollTax -
                checkProgressive(checkTax(reduceGirlPayRoll))) +
            totalAmount * (checkTax(totalAmount)) -
            progressiveFee +
            checkDividendTotalFee;
        // 男方薪資扣除部分扣除額 *稅率 - 累進 +
      }
    }
  }

  double checkAmountDoubleMixPayrollReduce(
      String payrollReduceWho, bool isDividend) //薪資分開合併
  {
    if (payrollReduceWho == 'man') {
      var reduceManPayRoll = (amountMan - taxExemption - payrollDeductions);
      var reduceManPayRollTax = checkTax(reduceManPayRoll);

      var amountTotal = amountGirl;
      var dividendTotal = dividendMan + dividendGirl;

      if (isDividend) {
        var totalAmount = amountTotal +
            dividendTotal -
            (taxExemption + standardDeduction * 2 + payrollDeductions);

        var checkDividendTotalFee = (dividendTotal * (0.085) >= 80000)
            ? 80000
            : dividendTotal * (0.085); //股利分開扣除

        print("男生總額${reduceManPayRoll} 稅率${reduceManPayRollTax}");
        print("剩下總額${totalAmount} 稅率${checkTax(totalAmount)}");

        return (reduceManPayRoll * reduceManPayRollTax -
                checkProgressive(checkTax(reduceManPayRoll))) +
            totalAmount * (checkTax(totalAmount)) -
            checkDividendTotalFee -
            checkProgressive(checkTax(totalAmount));
        //男方薪資扣除部分扣除額 * 稅率  -累進稅率 + 剩下的薪資+股利 * 稅率 - 股利合併稅 - 累進稅率
      } else {
        var totalAmount = amountGirl -
            (taxExemption + standardDeduction * 2 + payrollDeductions);

        var progressiveFee = checkProgressive(checkTax(totalAmount)); //累進稅率
        var checkDividendTotalFee = dividendTotal * 0.28;

        print("男生總額${reduceManPayRoll} 稅率${reduceManPayRollTax}");
        print("剩下總額${totalAmount} 稅率${checkTax(totalAmount)}");

        return (reduceManPayRoll * reduceManPayRollTax -
                checkProgressive(checkTax(reduceManPayRoll))) +
            totalAmount * (checkTax(totalAmount)) -
            progressiveFee +
            checkDividendTotalFee;
        // 男方薪資扣除部分扣除額 *稅率 - 累進 +
      }
    } else {
      var reduceGirlPayRoll = (amountGirl - taxExemption - payrollDeductions);
      var reduceGirlPayRollTax = checkTax(reduceGirlPayRoll);

      var amountTotal = amountMan;
      var dividendTotal = dividendMan + dividendGirl;

      if (isDividend) {
        var totalAmount = amountTotal +
            dividendTotal -
            (taxExemption + standardDeduction * 2 + payrollDeductions);

        var checkDividendTotalFee = (dividendTotal * (0.085) >= 80000)
            ? 80000
            : dividendTotal * (0.085); //股利分開扣除

        print("女生總額${reduceGirlPayRoll} 稅率${reduceGirlPayRollTax}");
        print("剩下總額${totalAmount} 稅率${checkTax(totalAmount)}");

        return (reduceGirlPayRoll * reduceGirlPayRollTax -
                checkProgressive(checkTax(reduceGirlPayRoll))) +
            totalAmount * (checkTax(totalAmount)) -
            checkDividendTotalFee -
            checkProgressive(checkTax(totalAmount));
        //女方薪資扣除部分扣除額 * 稅率  -累進稅率 + 剩下的薪資+股利 * 稅率 - 股利合併稅 - 累進稅率
      } else {
        var totalAmount = amountMan -
            (taxExemption + standardDeduction * 2 + payrollDeductions);

        var progressiveFee = checkProgressive(checkTax(totalAmount)); //累進稅率
        var checkDividendTotalFee = dividendTotal * 0.28;

        print("女生總額${reduceGirlPayRoll} 稅率${reduceGirlPayRollTax}");
        print("剩下總額${totalAmount} 稅率${checkTax(totalAmount)}");

        return (reduceGirlPayRoll * reduceGirlPayRollTax -
                checkProgressive(checkTax(reduceGirlPayRoll))) +
            totalAmount * (checkTax(totalAmount)) -
            progressiveFee +
            checkDividendTotalFee;
        // 女方薪資扣除部分扣除額 *稅率 - 累進 + 股利稅
      }
    }
  }

  double checkAmountDoubleMix(bool isDividend) {
    //全部合併
    var taxExemption = this.taxExemption * 2; //免稅扣除額
    var standardDeduction = this.standardDeduction * 2; //標準扣除額
    var payrollDeductions = this.payrollDeductions * 2; //薪資扣除額

    var amountTotal = amountMan + amountGirl;
    var dividendTotal = dividendMan + dividendGirl;

    var deduction = taxExemption + standardDeduction + payrollDeductions;

    if (isDividend) {
      //股利合併
      var totalAmount = (amountTotal + dividendTotal - deduction); //總金額

      var checkDividendTotalFee = (dividendTotal * (0.085) >= 80000)
          ? 80000
          : dividendTotal * (0.085); //股利分開扣除

      var progressiveFee = checkProgressive(checkTax(totalAmount)); //累進稅率

      print("總額${totalAmount} 稅率${(checkTax(totalAmount))}");

      return totalAmount * (checkTax(totalAmount)) -
          checkDividendTotalFee -
          progressiveFee;
      //總金額*稅%-股利分開扣除額-累進稅率
    } else {
      var totalAmount = amountTotal - deduction;
      var progressiveFee = checkProgressive(checkTax(totalAmount)); //累進稅率
      var checkDividendTotalFee = dividendTotal * 0.28;

      print("總額${totalAmount} 稅率${(checkTax(totalAmount))}");

      return totalAmount * (checkTax(totalAmount)) -
          progressiveFee +
          checkDividendTotalFee;
      //總金額 * 稅% - 累進 + 股利稅
    }
  }

  // double checkAmountSingle() {
  //   var taxExemption = 97000; //免稅扣除額
  //   var standardDeduction = 131000; //標準扣除額
  //   var payrollDeductions = 218000; //薪資扣除額
  //
  //   var deduction = taxExemption + standardDeduction + payrollDeductions;
  //   var amount = 1400000; //薪資
  //   var dividend = 4000000; //股利
  //   var isDividend = false; //股利使否合併計算
  //
  //   if (isDividend) {
  //     //股利合併
  //     var totalAmount = (amount + dividend - deduction); //總金額
  //
  //     var checkDividendTotalFee =
  //         (dividend * (0.085) >= 80000) ? 80000 : dividend * (0.085); //股利分開扣除
  //
  //     var progressiveFee = checkProgressive(checkTax(totalAmount)); //累進稅率
  //
  //     return totalAmount * (checkTax(totalAmount)) -
  //         checkDividendTotalFee -
  //         progressiveFee;
  //     //總金額*稅%-股利分開扣除額-累進稅率
  //   } else {
  //     var totalAmount = amount - deduction;
  //     var progressiveFee = checkProgressive(checkTax(totalAmount)); //累進稅率
  //     var checkDividendTotalFee = dividend * 0.28;
  //     return totalAmount * (checkTax(totalAmount)) -
  //         progressiveFee +
  //         checkDividendTotalFee;
  //     //總金額 * 稅% - 累進 + 股利稅
  //   }
  // }

  int checkProgressive(double tax) {
    if (tax == 0.05) {
      return 0;
    } else if (tax == 0.12) {
      return 41300;
    } else if (tax == 0.2) {
      return 147700;
    } else if (tax == 0.3) {
      return 413700;
    } else if (tax == 0.4) {
      return 911700;
    } else {
      return 0;
    }
  }

  double checkTax(int amount) {
    if (0 < amount && amount <= 590000) {
      return 0.05;
    } else if (590000 < amount && amount <= 1330000) {
      return 0.12;
    } else if (1330000 < amount && amount <= 2660000) {
      return 0.2;
    } else if (2660000 < amount && amount <= 4980000) {
      return 0.3;
    } else if (amount > 4980000) {
      return 0.4;
    } else {
      return 0;
    }
  }

  void check() {
    message.value = '';
    message.value += "全部合併 股利合併${checkAmountDoubleMix(true)}\n";
    message.value += "全部合併 股利分開${checkAmountDoubleMix(false)}\n";
    message.value += "薪資分開合併 男生分開 股利合併${checkAmountDoubleMixPayrollReduce('man', true)}\n";
    message.value += "薪資分開合併 男生分開 股利分開${checkAmountDoubleMixPayrollReduce('man', false)}\n";
    message.value += "薪資分開合併 女生分開 股利合併${checkAmountDoubleMixPayrollReduce('girl', true)}\n";
    message.value += "薪資分開合併 女生分開 股利分開${checkAmountDoubleMixPayrollReduce('girl', false)}\n";
    message.value += "各類分開合併 男生分開 股利合併${checkAmountDoubleAllReduce('man', true)}\n";
    message.value += "各類分開合併 女生分開 股利合併${checkAmountDoubleAllReduce('girl', true)}\n";
    message.value += "各類分開合併 男生分開 股利分開${checkAmountDoubleAllReduce('man', false)}\n";
    message.value += "各類分開合併 女生分開 股利分開${checkAmountDoubleAllReduce('girl', false)}\n";
  }
}
