import 'package:flutter/material.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';
import 'package:shopora_e_commerce/views/widgets/location_item.dart';
import 'package:shopora_e_commerce/views/widgets/title_and_textField_component.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  late TextEditingController locationController;
  @override
  void initState() {
    super.initState();
    locationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Address"), centerTitle: true),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your location",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  "Lets find your unforgettable event.Choose a location below to get stated",
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Colors.grey),
                ),
                SizedBox(height: size.height * 0.03),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 18.0,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: AppColors.black12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: AppColors.red),
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    prefixIcon: Icon(
                      Icons.location_on_outlined,
                      size: size.height * 0.035,
                    ),

                    hintText: "Enter location like city-country",
                    hintStyle: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColors.black45),
                    suffixIcon: Icon(Icons.add, size: size.height * 0.035),
                    suffixIconColor: AppColors.grey,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  "Select Location",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: size.height * 0.02),

                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dummyLocations.length,

                  itemBuilder: (context, index) {
                    final location = dummyLocations[index];
                    return LocationItem(location: location);
                  },
                ),
                SizedBox(height: size.height * 0.01),

                CustomButton(onPressed: () {}, title: "Confirm"),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
