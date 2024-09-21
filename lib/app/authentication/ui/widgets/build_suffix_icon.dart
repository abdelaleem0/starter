import 'package:starter/common/blocs/app_language/app_language_bloc.dart';
import 'package:starter/common/blocs/app_language/app_language_state.dart';
import 'package:starter/common/utils/bottom_sheets/show_bottom_sheet_common.dart';
import 'package:starter/common/ui/custom_widgets/app_text_fields/app_text_form_field.dart';
import 'package:starter/common/utils/app_style/app_colors.dart';
import 'package:starter/common/utils/app_style/text_styles.dart';
import 'package:starter/common/utils/dimensions.dart';
import 'package:starter/app/authentication/utils/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildSuffixIcon extends StatefulWidget {
  final void Function(Country country) getCountry;

  const BuildSuffixIcon({super.key, required this.getCountry});

  @override
  State<BuildSuffixIcon> createState() => _BuildSuffixIconState();
}

class _BuildSuffixIconState extends State<BuildSuffixIcon> {
  Country selectedCountry = const Country(
    name: "Saudi Arabia",
    arabicName: "المملكة العربية السعودية",
    flag: "🇸🇦",
    code: "SA",
    dialCode: "966",
    minLength: 10,
    maxLength: 10,
  );

  void showAlert() async {
    final alert = await appBottomSheetCommon<Country>(
      context,
      builder: (BuildContext context) => const FlagsForm(),
    );
    if (alert != null) {
      selectedCountry = alert;
      widget.getCountry(selectedCountry);
      setState(() {});
    }
  }

  @override
  void initState() {
    widget.getCountry(selectedCountry);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showAlert(),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.arrow_drop_down_outlined,
            color: Colors.black,
          ),
          const SizedBox(
            width: PaddingDimensions.small,
          ),
          Text(
            "${selectedCountry.dialCode}+",
            style: TextStyles.regular(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: PaddingDimensions.small,
          ),
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(18),
              child: Image.asset(
                "images/assets/flags/${selectedCountry.code.toLowerCase()}.png",
                width: 32,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            width: PaddingDimensions.large - 5,
          ),
        ],
      ),
    );
  }
}

class FlagsForm extends StatefulWidget {
  const FlagsForm({super.key});

  @override
  State<FlagsForm> createState() => _FlagsFormState();
}

class _FlagsFormState extends State<FlagsForm> {
  final _searchController = TextEditingController();

  // late List<Country> _filteredCountries;

  List<Country> countryList = countries;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .9,
      padding: const EdgeInsets.all(PaddingDimensions.large),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.neutralColors5,
            ),
          ),
          const SizedBox(
            height: PaddingDimensions.large,
          ),
          AppTextFormField(
            isShadowColor: Colors.transparent,
            controller: _searchController,
            hint: "search",
            suffix: Icon(
              Icons.search,
              color: AppColors.neutralColors5.withOpacity(0.5),
            ),
            onchange: (value) {
              countryList = countries;
              var searchCountry = countryList.where((element) {
                final searchEnglish =
                    element.name.toLowerCase().contains(value.toLowerCase());
                if (searchEnglish) {
                  return searchEnglish;
                } else {
                  return element.arabicName
                      .toLowerCase()
                      .contains(value.toLowerCase());
                }
              }).toList();
              countryList = searchCountry;
              setState(() {});
            },
          ),
          const SizedBox(
            height: PaddingDimensions.large,
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                key: ValueKey(countryList.length),
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.of(context).pop(countryList[index]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(PaddingDimensions.normal),
                              // Border width
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size:
                                      const Size.fromRadius(PaddingDimensions.large),
                                  child: Image.asset(
                                    "images/assets/flags/${countryList[index].code.toLowerCase()}.png",
                                    // package: 'intl_phone_field',
                                    width: 35,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: PaddingDimensions.small,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: BlocBuilder<AppLanguageBloc,
                                  AppLanguageState>(builder: (context, state) {
                                return Text(
                                  state.locale.languageCode == 'ar'
                                      ? countryList[index].arabicName
                                      : countryList[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.regular(
                                    fontSize: Dimensions.normal,
                                    color: Colors.black,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        Text(
                          "${countryList[index].dialCode}+",
                          style: TextStyles.regular(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: countryList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
