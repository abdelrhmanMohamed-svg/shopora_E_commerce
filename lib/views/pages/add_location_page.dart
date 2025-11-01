import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopora_e_commerce/model/location_item_model.dart';
import 'package:shopora_e_commerce/model_views/location_cubit/loaction_cubit.dart';
import 'package:shopora_e_commerce/utils/app_colors.dart';
import 'package:shopora_e_commerce/views/widgets/custom_button.dart';
import 'package:shopora_e_commerce/views/widgets/custom_snack_bar.dart';
import 'package:shopora_e_commerce/views/widgets/location_item.dart';
import 'package:shopora_e_commerce/views/widgets/title_and_textField_component.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  late TextEditingController locationController;
  @override
  void initState() {
    super.initState();
    locationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final locationCubit = BlocProvider.of<LoactionCubit>(context);
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
                  controller: locationController,
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
                    suffixIcon: BlocBuilder<LoactionCubit, LoactionState>(
                      bloc: locationCubit,
                      buildWhen: (previous, current) =>
                          current is LocationAdding || current is LoactionAdded,
                      builder: (context, state) {
                        if (state is LocationAdding) {
                          return Transform.scale(
                            scale: 0.6,
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }

                        return InkWell(
                          onTap: () {
                            if (locationController.text.isEmpty) {
                              showCustomSnackBar(
                                context,
                                "Please enter location",
                              );
                            } else if (!locationController.text.contains(",")) {
                              showCustomSnackBar(
                                context,
                                "Please enter valid location",
                              );
                            } else {
                              locationCubit.addLocation(
                                locationController.text,
                              );
                              locationController.clear();
                            }
                          },
                          child: Icon(Icons.add, size: size.height * 0.035),
                        );
                      },
                    ),
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

                BlocBuilder<LoactionCubit, LoactionState>(
                  bloc: locationCubit,
                  buildWhen: (previous, current) =>
                      current is LoactionsLoaded ||
                      current is LoactionError ||
                      current is LoactionLoading,
                  builder: (context, state) {
                    if (state is LoactionLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is LoactionError) {
                      return Center(child: Text(state.message));
                    } else if (state is LoactionsLoaded) {
                      final locations = state.locations;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: locations.length,

                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return LocationItem(location: location);
                        },
                      );
                    } else {
                      return Center(child: Text("something went wrong"));
                    }
                  },
                ),
                SizedBox(height: size.height * 0.02),

                BlocConsumer<LoactionCubit, LoactionState>(
                  listenWhen: (previous, current) =>
                      current is ConfirmLocationSuccess,
                  listener: (context, state) {
                    if (state is ConfirmLocationSuccess) {
                      Navigator.of(context).pop();
                    }
                  },
                  bloc: locationCubit,
                  buildWhen: (previous, current) =>
                      current is ConfirmLocationLoading ||
                      current is ConfirmLocationSuccess ||
                      current is ConfirmLocationError,
                  builder: (context, state) {
                    if (state is ConfirmLocationLoading) {
                      return CustomButton(
                        onPressed: null,
                        child: const CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return CustomButton(
                        onPressed: () {
                          locationCubit.confirmLocation();
                        },
                        title: "Confirm",
                      );
                    }
                  },
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
