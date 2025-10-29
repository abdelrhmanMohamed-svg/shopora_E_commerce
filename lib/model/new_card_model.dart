class NewCardModel {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvvCode;

  NewCardModel({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvvCode,
  });
}

List<NewCardModel> dummyNewCards = [
  NewCardModel(
    cardNumber: "0156874985214786",
    cardHolderName: "Abderlhaman",
    expiryDate: "02/27",
    cvvCode: "333",
  ),
  NewCardModel(
    cardNumber: "0156874985214786",
    cardHolderName: "Tarek",
    expiryDate: "02/29",
    cvvCode: "253",
  ),
];
