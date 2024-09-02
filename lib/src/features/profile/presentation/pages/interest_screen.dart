import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:you_app/src/core/constant/app_assets.dart';
import 'package:you_app/src/core/constant/app_spacing.dart';
import 'package:you_app/src/core/extensions/theme_extension.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:you_app/src/features/profile/presentation/bloc/profile_event.dart';
import 'package:you_app/src/shared/dummy_widgets/app_background_container.dart';
import 'package:you_app/src/shared/dummy_widgets/gradient_text.dart';
import 'package:you_app/src/shared/platform_widgets/platform_back_icon.dart';
import 'package:you_app/src/theme/app_theme.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  static const routeName = '/interest';

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  late double _distanceToField;
  late StringTagController _stringTagController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void initState() {
    super.initState();
    _stringTagController = StringTagController();
  }

  @override
  void dispose() {
    super.dispose();
    _stringTagController.dispose();
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return Scaffold(
      body: AppBackgroundContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const PlatformBackIconWithText(),
                    GestureDetector(
                      onTap: () {
                        profileBloc.add(SaveInterestEvent(
                            interest: _stringTagController.getTags));
                        Navigator.pop(context);
                      },
                      child: const GradientText(
                        text: 'Save',
                        fontWeight: FontWeight.w600,
                        colors: [
                          Color(0xFFABFFFD),
                          Color(0xFF4599DB),
                          Color(0xFFAADAFF),
                        ],
                      ),
                    )
                  ],
                ),
                AppSpacing.setVerticalSpace(80),
                const GradientText(
                  text: 'Tell everyone about yourself',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                AppSpacing.setVerticalSpace(10),
                Text(
                  'What interest you?',
                  style: context.textTheme.displayLarge,
                ),
                AppSpacing.setVerticalSpace(40),
                TextFieldTags<String>(
                  textfieldTagsController: _stringTagController,
                  initialTags: profileBloc.state.profile?.interest,
                  textSeparators: const [' ', ','],
                  letterCase: LetterCase.normal,
                  validator: (String tag) {
                    if (_stringTagController.getTags!.contains(tag)) {
                      return 'You\'ve already entered that';
                    }
                    return null;
                  },
                  inputFieldBuilder: (context, inputFieldValues) {
                    return TextField(
                      onTap: () {
                        _stringTagController.getFocusNode?.requestFocus();
                      },
                      controller: inputFieldValues.textEditingController,
                      focusNode: inputFieldValues.focusNode,
                      decoration: InputDecoration(
                        isDense: true,
                        border: _border(AppTheme.kcWhiteColor.withOpacity(0.1)),
                        focusedBorder:
                            _border(AppTheme.kcWhiteColor.withOpacity(0.1)),
                        helperStyle: context.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.kcWhiteColor.withOpacity(0.6)),
                        hintText: inputFieldValues.tags.isNotEmpty ? '' : " ",
                        errorText: inputFieldValues.error,
                        prefixIconConstraints:
                            BoxConstraints(maxWidth: _distanceToField * 0.8),
                        prefixIcon: inputFieldValues.tags.isNotEmpty
                            ? SingleChildScrollView(
                                controller:
                                    inputFieldValues.tagScrollController,
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    left: 8,
                                  ),
                                  child: Wrap(
                                      runSpacing: 4.0,
                                      spacing: 4.0,
                                      children: inputFieldValues.tags
                                          .map((String tag) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(4),
                                            ),
                                            color: AppTheme.kcWhiteColor
                                                .withOpacity(0.2),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              InkWell(
                                                child: Text(
                                                  tag,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onTap: () {
                                                  //print("$tag selected");
                                                },
                                              ),
                                              const SizedBox(width: 4.0),
                                              InkWell(
                                                child: SvgPicture.asset(
                                                    AppAsset.cancelIcon),
                                                onTap: () {
                                                  inputFieldValues
                                                      .onTagRemoved(tag);
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList()),
                                ),
                              )
                            : null,
                      ),
                      onChanged: inputFieldValues.onTagChanged,
                      onSubmitted: inputFieldValues.onTagSubmitted,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
