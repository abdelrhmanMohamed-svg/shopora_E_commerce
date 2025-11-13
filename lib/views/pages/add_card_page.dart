import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model_views/payment_cubit/payment_cubit.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';
import 'package:shopora_e_commerce/views/widgets/title_and_textField_component.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController cardNumberController;
  late TextEditingController cardHolderNameController;
  late TextEditingController expiryDateController;
  late TextEditingController cvvController;
  @override
  void initState() {
    super.initState();
    cardNumberController = TextEditingController();
    cardHolderNameController = TextEditingController();
    expiryDateController = TextEditingController();
    cvvController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final paymentCubit = BlocProvider.of<PaymentCubit>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Add New Card"), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TitleAndTextfieldComponent(
                    title: "Card Number",
                    hintText: "Enter Card Number",
                    prefixIcon: Icons.credit_card,
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter card number";
                      }
                      if (value.length != 16) {
                        return "Please enter valid card number";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  TitleAndTextfieldComponent(
                    title: "Card Holder Name",
                    hintText: "Enter Holder Name",
                    prefixIcon: Icons.person_2_outlined,
                    controller: cardHolderNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter card holder name";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  TitleAndTextfieldComponent(
                    title: "Expiry Date",
                    hintText: "MM/YY",
                    prefixIcon: Icons.date_range,
                    controller: expiryDateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter expiry date";
                      }
                      if (!value.contains("/")) {
                        return "Please expiry date should be in MM/YY format";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  TitleAndTextfieldComponent(
                    title: "CVV Code",
                    hintText: "CVV",
                    prefixIcon: Icons.lock_outline,
                    controller: cvvController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter cvv code";
                      }
                      if (value.length != 3) {
                        return "Please enter valid cvv code";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.24),

                  BlocConsumer<PaymentCubit, PaymentState>(
                    listenWhen: (previous, current) => current is NewCardAdded,
                    listener: (context, state) {
                      if (state is NewCardAdded) {
                        Navigator.of(context).pop();
                      }
                    },
                    bloc: paymentCubit,
                    buildWhen: (previous, current) =>
                        current is NewCardAdded ||
                        current is AddingNewCard ||
                        current is ErrorAddingNewCard,
                    builder: (context, state) {
                      if (state is AddingNewCard) {
                        return CustomButton(
                          child: const CircularProgressIndicator.adaptive(),
                        );
                      } else if (state is ErrorAddingNewCard) {
                        return CustomButton(title: "Failed to add card");
                      } else {
                        return CustomButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await paymentCubit.addToCard(
                                cardNumberController.text,
                                cardHolderNameController.text,
                                expiryDateController.text,
                                cvvController.text,
                              );
                            }
                          },
                          title: "Add Card",
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
