import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../common_widgets/LoginButton.dart';
import '../common_widgets/formNo.dart';
import '../common_widgets/formWidget.dart';
import '../common_widgets/loginCircular.dart';
import '../const/assets.dart';
import '../const/snackbar.dart';
import '../const/strings.dart';
import '../const/styles.dart';
import '../repository/remote_data/queries.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

String? myGender = 'Flat';
List<String> Genders = [
  'Flat',
  'Self-Contain',
  'Duplex',
];

String? myStatus = 'Tenant';
List<String> Status = [
  'Tenant',
  'Owner',
  'Squatter',
];

class _VerificationScreenState extends State<VerificationScreen> {
  File? _image;
  String? base64PersonImage;

  pickImage(ImageSource source) async {

    try{
      final XFile? image = await ImagePicker().pickImage(source: source, imageQuality: 25);
      if(image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        _image = imageTemporary;
        base64PersonImage = base64Encode(_image!.readAsBytesSync());
      });
    } on PlatformException catch (e){
      debugPrint('$e');
    }
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _landEmailController = TextEditingController();
  TextEditingController _landPhController = TextEditingController();
  TextEditingController _rentValueController = TextEditingController();
  TextEditingController _tenantAddressController = TextEditingController();
  TextEditingController _businessNameController = TextEditingController();
  TextEditingController _approvedAmountController = TextEditingController();
  TextEditingController _clientAddressController = TextEditingController();


  bool _checkBox = false;
  String? auto;
  String? autoOne;
  String? autoTwo;
  bool _nextCheckBox = false;
  bool _nextCheckBoxOne = false;
  bool _checkBoxOne = false;
  bool _checkBoxTwo = false;
  bool _nextCheckBoxTwo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLoanCard,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15.r, right: 15.r, top: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.kCompleteSetup, style: kFaqStyle,),
                SizedBox(height: 5.h,),
                Text(Strings.UpdateProfile, style: kFeatureStyle,),
                SizedBox(height: 15.h,),
                FormWidget(text: Strings.kName, hText: 'name', controller: _nameController),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kEmail, hText: 'Email', controller: _emailController),
                SizedBox(height: 10.h,),
                FormNum(text: Strings.kPhn, hText: 'Phone no.', controller: _phoneController),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kLandE, hText: 'email', controller: _landEmailController),
                SizedBox(height: 10.h,),
                FormNum(text: Strings.kLandN, hText: 'Phone no.', controller: _landPhController,),
                SizedBox(height: 10.h,),
                Text('Apartment Type', style: kFirstN,),
                SizedBox(height: 5.h,),
                DropdownButtonHideUnderline(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 42.h,
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(12.0.r)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0.r),
                      child: DropdownButton(
                        items: Genders.map((items) {
                          return DropdownMenuItem<String>(value: items,child: Text(items, style: kDetailAccount,),);
                        }).toList(),
                        value: myGender,
                        onChanged: (value){
                          setState(() {
                            myGender = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 15.h,),
                // Text(Strings.kProfileP, style: kFirstN),
                // SizedBox(height: 7.h,),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   height: 180.0.h,
                //   child: Column(
                //     children: [
                //       Container(
                //         width: MediaQuery.of(context).size.width -10,
                //         height: 120.h,
                //         color: kSignup,
                //         child: base64PersonImage != null ? Image.file(_image!, fit: BoxFit.cover,) :
                //         Image.asset(Assets.group, fit: BoxFit.cover,),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.only(left: 5.0.r),
                //         child: IntrinsicHeight(
                //           child: Row(
                //             children: [
                //               Container(
                //                 padding: EdgeInsets.only(left: 13.0.r, right: 18.0.r, top: 10.0.r, bottom: 10.0.r),
                //                 height: 60.h,
                //                 decoration: BoxDecoration(
                //                   color: kWhite,
                //                   borderRadius: BorderRadius.only(
                //                     bottomLeft: Radius.circular(10.0.r),
                //                     bottomRight: Radius.circular(10.0.r),
                //                   ),
                //                 ),
                //                 child: Row(
                //                   children: [
                //                     InkWell(
                //                       onTap:(){
                //                         pickImage(ImageSource.camera);
                //                       },
                //                       child: Row(
                //                         children: [
                //                           SizedBox(child: Image.asset(Assets.camera)),
                //                           SizedBox(width: 15.w,),
                //                           Text(Strings.kPicture, style: kDetailAccount),
                //                         ],
                //                       ),
                //                     ),
                //                     VerticalDivider(
                //                       width: 36.w,
                //                       thickness: 2.0,
                //                       color: kDivide,
                //                     ),
                //                     InkWell(
                //                       onTap: (){
                //                         pickImage(ImageSource.gallery);
                //                       },
                //                       child: Row(
                //                         children: [
                //                           SizedBox(child: Image.asset(Assets.gallery)),
                //                           SizedBox(width: 15.w,),
                //                           Text(Strings.kUpload, style: kDetailAccount)
                //                         ],
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 10.h,),
                FormNum(text: Strings.kRentV, hText: 'answer', controller: _rentValueController),
                SizedBox(height: 10.h,),
                Text(Strings.kOwed, style: kFirstN),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160.w,
                      height: 58.h,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: kWhite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0.r, right: 15.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Strings.kYes, style: kFirstN),
                              Checkbox(
                                value: _checkBox,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _nextCheckBox == false){
                                    setState(() {
                                      _checkBox = value;
                                      auto = 'Yes';
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 58.h,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: kWhite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0.r, right: 15.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Strings.kNo, style: kFirstN),
                              Checkbox(
                                value: _nextCheckBox,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _checkBox == false){
                                    setState(() {
                                      _nextCheckBox = value;
                                      auto = 'No';
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kTenantA, hText: 'address', controller: _tenantAddressController),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kBusN, hText: 'Business name', controller: _businessNameController),
                SizedBox(height: 10.h,),
                FormNum(text: Strings.kMerchantAmount, hText: 'approved amount', controller: _approvedAmountController,),
                SizedBox(height: 10.h,),
                FormWidget(text: Strings.kClientA, hText: 'Client Address', controller: _clientAddressController),
                SizedBox(height: 10.h,),
                Text('Ownership status', style: kFirstN,),
                SizedBox(height: 5.h,),
                DropdownButtonHideUnderline(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 42.h,
                    decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(12.0.r)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0.r),
                      child: DropdownButton(
                        items: Status.map((items) {
                          return DropdownMenuItem<String>(value: items,child: Text(items, style: kDetailAccount,),);
                        }).toList(),
                        value: myStatus,
                        onChanged: (value){
                          setState(() {
                            myStatus = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                Text(Strings.kItem, style: kFirstN),
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160.w,
                      height: 58.h,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: kWhite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0.r, right: 15.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Strings.kYes, style: kFirstN),
                              Checkbox(
                                value: _checkBoxOne,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _nextCheckBoxOne == false){
                                    setState(() {
                                      _checkBoxOne = value;
                                      autoOne = 'Yes';
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 58.h,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: kWhite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0.r, right: 15.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Strings.kNo, style: kFirstN),
                              Checkbox(
                                value: _nextCheckBoxOne,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _checkBoxOne == false){
                                    setState(() {
                                      _nextCheckBoxOne = value;
                                      autoOne = 'No';
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h,),
                Text(Strings.kAfford, style: kFirstN),
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160.w,
                      height: 58.h,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: kWhite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0.r, right: 15.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Strings.kYes, style: kFirstN),
                              Checkbox(
                                value: _checkBoxTwo,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _nextCheckBoxTwo == false){
                                    setState(() {
                                      _checkBoxTwo = value;
                                      autoTwo = 'Yes';
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 58.h,
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: kWhite,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.0.r, right: 15.0.r),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(Strings.kNo, style: kFirstN),
                              Checkbox(
                                value: _nextCheckBoxTwo,
                                checkColor: kWhite,
                                activeColor: kSafeGreen,
                                onChanged: (bool? value){
                                  if(value != null && _checkBoxTwo == false){
                                    setState(() {
                                      _nextCheckBoxTwo = value;
                                      autoTwo = 'No';
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.h,),
                Consumer<VerificationRepo>(
                  builder: (context, verify, child) {
                    return GestureDetector(
                      onTap: ()async{
                        await verify.verifyUsers(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                          landlord_email: _landEmailController.text,
                            landlord_phone: _landPhController.text,
                            apartment_type: myGender.toString(),
                            rent_value: _rentValueController.text,
                            owed_previous: auto.toString(),
                            tenant_address: _tenantAddressController.text,
                            business_name: _businessNameController.text,
                            approve_amount: _approvedAmountController.text,
                            client_address: _clientAddressController.text,
                            device_status: autoOne.toString(),
                            ownership_status: myStatus.toString(),
                            client_afford: autoTwo.toString(),
                        );
                        debugPrint("message:::  ${verify.resMessage}");
                        if(verify.resStatusCode == 200){
                          showingSnacks(context, verify.resMessage);
                          // Future.delayed(Duration(seconds: 1));
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
                        }else{
                          showingErrorSnacks(context, verify.resMessage);
                        }
                      },
                        child: verify.isLoading? LoginCircular(text: '', style: kLoginButton,):
                        LoginB(text: Strings.kConfirm, style: kLoginButton),
                    );
                  }
                ),
                SizedBox(height: 25.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
