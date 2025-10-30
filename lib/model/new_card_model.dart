// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvvCode;
  final bool isSelected;

  NewCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvvCode,
    this.isSelected = false,
  });

  NewCardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvvCode,
    bool? isSelected,
  }) {
    return NewCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvvCode: cvvCode ?? this.cvvCode,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

List<NewCardModel> dummyNewCards = [
  NewCardModel(
    id: "1",
    cardNumber: "0156874985214786",
    cardHolderName: "Abderlhaman",
    expiryDate: "02/27",
    cvvCode: "333",
  ),
  NewCardModel(
    id: "2",
    cardNumber: "0156874985215555",
    cardHolderName: "Tarek",
    expiryDate: "02/29",
    cvvCode: "253",
  ),
];
