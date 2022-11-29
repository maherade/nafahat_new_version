import 'package:flutter_svg/svg.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field.dart';
import '../widget/custom_cart_product_item.dart';
import '../widget/stepper.dart';
class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController cvcController = TextEditingController();

  int currentStepperIndex = 0;

  int quantity = 0;

List deliveryAddress=["السعودية-الرياض","استخدام عنوان آخر"];
String? selectedAddress;

  List paymentMethods=["visa","استخدام طريقة آخرى"];
  String? selectedPaymentMethods;

  List anotherPaymentMethod=["credit","paypal"];
  String? selectedAnotherPaymentMethod;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50.h,),
        StepperRealEstates(currentStepperIndex),
        SizedBox(height: 24.h,),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      Container(
                        height: 40.h,
                        decoration:const BoxDecoration(
                          color: AppColors.primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        CustomText('المنتجات',fontSize: 12.sp,fontWeight: FontWeight.normal,color: AppColors.whiteColor,),
                        CustomText('السعر',fontSize: 12.sp,fontWeight: FontWeight.normal,color: AppColors.whiteColor,),
                        CustomText('الكمية',fontSize: 12.sp,fontWeight: FontWeight.normal,color: AppColors.whiteColor,),
                        CustomText('المجموع',fontSize: 12.sp,fontWeight: FontWeight.normal,color: AppColors.whiteColor,),
                        CustomText('',fontSize: 12.sp,fontWeight: FontWeight.normal,color: AppColors.whiteColor,),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h,),
                     ListView.builder(
                       padding: EdgeInsets.zero,
                       shrinkWrap: true,
                       physics:const NeverScrollableScrollPhysics(),
                       itemCount: 3,
                       itemBuilder: (context, index) {
                       return CustomCartProductItem(
                         imgUrl: 'https://pngimg.com/uploads/perfume/perfume_PNG99991.png',
                         price: '40',
                         quantity: quantity.toString(),
                         total: '40',
                         onTapTrash: (){},
                         onTapIncrease: (){
                           setState(() => quantity++);
                         },
                         onTapDecrease: (){
                           setState(() => quantity--);
                         },
                       );
                     },),
                    ],
                  ),
                ),
                SizedBox(height: 32.h,),
                currentStepperIndex == 0 ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 22.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.greyBorder)
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                            color:const Color(0xffF2F1F1),
                            borderRadius: BorderRadius.circular(8.r)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText('المجموع الكلي',fontSize: 16.sp,),
                            SizedBox(height: 15.h,),
                            CustomText('انت تمتلك 4 منتجات بالسلة',fontSize: 14.sp,color: AppColors.hintGrey,),
                          ],
                        ),
                      ),
                      SizedBox(height: 25.h,),
                      CustomButton(
                        onTap: (){
                          setState(() => currentStepperIndex = 1);
                        },
                        height: 40.h,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText('تأكيد',fontWeight: FontWeight.normal,color: AppColors.whiteColor,fontSize: 16.sp,),
                            SizedBox(width: 14.w,),
                            const Icon(Icons.arrow_forward,color: AppColors.whiteColor,)
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      CustomButton(
                        onTap: (){},
                        height: 40.h,
                        title: 'استمرار عملية الشراء',
                        titleColor: AppColors.hintGrey,
                        color: AppColors.whiteColor,
                        borderColor: AppColors.hintGrey,
                      ),

                    ],
                  ),
                )
                    : currentStepperIndex==1 ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 22.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.greyBorder)
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                color:const Color(0xffF2F1F1),
                                borderRadius: BorderRadius.circular(8.r)
                            ),
                            child:CustomText('عنوان التسليم',fontSize: 16.sp,),

                          ),
                          SizedBox(height: 17.h,),
                          addRadioButtonDelivery(0,'السعودية - الرياض'),
                          SizedBox(height: 25.h,),
                          addRadioButtonDelivery(1,'استخدام عنوان آخر'),

                        ],
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 22.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.greyBorder)
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                color:const Color(0xffF2F1F1),
                                borderRadius: BorderRadius.circular(8.r)
                            ),
                            child:CustomText('طريقة الدفع',fontSize: 16.sp,),

                          ),
                          SizedBox(height: 17.h,),
                          addRadioButtonPayment(0,'visa'),
                          SizedBox(height: 25.h,),
                          addRadioButtonPayment(1,'استخدام طريقة آخرى'),

                        ],
                      ),
                    ),
                    SizedBox(height: 32.h,),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 19.0.w),
                      child: CustomButton(
                        onTap: (){
                          setState(() => currentStepperIndex = 2);
                        },
                        height: 40.h,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText('دفع 15222 ر.س',fontWeight: FontWeight.normal,color: AppColors.whiteColor,fontSize: 16.sp,),
                            SizedBox(width: 14.w,),
                            const Icon(Icons.arrow_forward,color: AppColors.whiteColor,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 29.h,),
                  ],
                ) : Column(
                  children: [
                    SizedBox(height: 25.h,),
                    Padding(
                     padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomText('المنتجات',fontWeight: FontWeight.normal,fontSize: 14.sp,),
                              SizedBox(width: 22.w,),
                              CustomText('3',fontWeight: FontWeight.normal,fontSize: 12.sp,color: AppColors.primaryColor,),
                            ],
                          ),
                          Row(
                            children: [
                              CustomText('القيمة النهائية',fontWeight: FontWeight.normal,fontSize: 14.sp,),
                              SizedBox(width: 22.w,),
                              CustomText('12000',fontWeight: FontWeight.normal,fontSize: 12.sp,color: AppColors.primaryColor,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 23.h,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 22.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.greyBorder)
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                color:const Color(0xffF2F1F1),
                                borderRadius: BorderRadius.circular(8.r)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText('عنوان التسليم',fontSize: 16.sp,),
                              ],
                            ),
                          ),
                          SizedBox(height: 29.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText('عنوان التسليم',fontSize: 14.sp,color:const Color(0xff6C6C6C),fontWeight: FontWeight.normal,),
                              CustomText('السعودية - الرياض',fontSize: 14.sp,fontWeight: FontWeight.normal,),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 24.h,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 22.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.greyBorder)
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                color:const Color(0xffF2F1F1),
                                borderRadius: BorderRadius.circular(8.r)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText('طريقة الدفع',fontSize: 16.sp,),
                              ],
                            ),
                          ),
                          SizedBox(height: 29.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText('طريقة الدفع',fontSize: 14.sp,color:const Color(0xff6C6C6C),fontWeight: FontWeight.normal,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomText('Visa',fontSize: 14.sp,fontWeight: FontWeight.normal,),
                                  CustomText('****123',fontSize: 14.sp,fontWeight: FontWeight.normal,),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 24.h,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 22.h),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.greyBorder)
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                                color:const Color(0xffF2F1F1),
                                borderRadius: BorderRadius.circular(8.r)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText('طريقة  التوصيل',fontSize: 16.sp,),
                              ],
                            ),
                          ),
                          SizedBox(height: 29.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText('طريقة  التوصيل',fontSize: 14.sp,color:const Color(0xff6C6C6C),fontWeight: FontWeight.normal,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomText('مجاناً',fontSize: 14.sp,fontWeight: FontWeight.normal,),
                                  CustomText('الثلاثاء 10 يناير',fontSize: 14.sp,fontWeight: FontWeight.normal,),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 54.h,),


                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

Widget addRadioButtonDelivery(int btnValue, String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Radio(
        activeColor: Theme.of(context).primaryColor,
        value: deliveryAddress[btnValue],
        groupValue: selectedAddress,
        onChanged: (value){
          setState(() {
            print(value);
            selectedAddress=value;
          });
        },
      ),
      selectedAddress == 'استخدام عنوان آخر' && btnValue == 1?Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 1.0, color: AppColors.greyBorder),
              ),
              child: CustomText(title,fontSize: 14.sp,fontWeight: FontWeight.normal,),
            ),
            SizedBox(height: 16.h,),
            CustomTextFormField(
              controller: addressController,
              hintText: 'الشارع والعنوان',
              fillColor: AppColors.greyBorder,
              suffixIcon: Padding(
                padding:  EdgeInsets.all(8.0.w),
                child: SvgPicture.asset(
                  'assets/svg/search.svg',
                  fit: BoxFit.contain,
                ),
              ),            ),
            SizedBox(height: 24.h,),
            CustomTextFormField(
              controller: cityController,
              hintText: 'الدولة',
              fillColor: AppColors.greyBorder,
              suffixIcon: Padding(
                padding:  EdgeInsets.all(8.0.w),
                child: SvgPicture.asset(
                  'assets/svg/location.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ): Expanded(
        child: Container(
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 1.0, color: AppColors.greyBorder),
          ),
          child: CustomText(title,fontSize: 14.sp,fontWeight: FontWeight.normal,),
        ),
      )
    ],
  );
}

Widget addRadioButtonPayment(int btnValue, String title) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Radio(
        activeColor: Theme.of(context).primaryColor,
        value: paymentMethods[btnValue],
        groupValue: selectedPaymentMethods,
        onChanged: (value){
          setState(() {
            print(value);
            selectedPaymentMethods=value;
          });
        },
      ),
      selectedPaymentMethods == 'استخدام طريقة آخرى' && btnValue == 1?Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 1.0, color: AppColors.greyBorder),
              ),
              child: CustomText(title,fontSize: 14.sp,fontWeight: FontWeight.normal,),
            ),
            Column(
              children: [
                Row(
                  children: [
                    addRadioButtonAnotherPayment(0,'credit'),
                    addRadioButtonAnotherPayment(1,'paypal'),
                  ],
                ),
                selectedAnotherPaymentMethod == 'credit'? Column(
                  children: [
                    SizedBox(height: 23.h,),
                    CustomTextFormField(
                      controller: fullNameController,
                      hintText: 'الإسم كامل',
                      fillColor: AppColors.greyBorder,
                    ),
                    SizedBox(height: 16.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: monthController,
                            hintText: 'الشهر',
                            fillColor: AppColors.greyBorder,
                          ),
                        ),
                        SizedBox(width: 27.w,),
                        Expanded(
                          child: CustomTextFormField(
                            controller: yearController,
                            hintText: 'السنة',
                            fillColor: AppColors.greyBorder,
                          ),
                        ),
                        SizedBox(width: 27.w,),
                        Expanded(
                          child: CustomTextFormField(
                            controller: cvcController,
                            hintText: 'CVC',
                            fillColor: AppColors.greyBorder,

                          ),
                        ),
                      ],
                    )
                  ],
                ) : SizedBox()


              ],
            ),
          ],
        ),
      ): Expanded(
        child: Container(
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 1.0, color: AppColors.greyBorder),
          ),
          child: CustomText(title,fontSize: 14.sp,fontWeight: FontWeight.normal,),
        ),
      )
    ],
  );
}

Widget addRadioButtonAnotherPayment(int btnValue, String img) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: anotherPaymentMethod[btnValue],
          groupValue: selectedAnotherPaymentMethod,
          onChanged: (value){
            setState(() {
              print(value);
              selectedAnotherPaymentMethod=value;
            });
          },
        ),
        SvgPicture.asset(
          'assets/svg/$img.svg',
          fit: BoxFit.contain,
        ),

      ],
    );
  }

}
