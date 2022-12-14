import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:perfume_store_mobile_app/controller/auth_controller.dart';
import 'package:perfume_store_mobile_app/view/custom_widget/custom_button.dart';
import 'package:perfume_store_mobile_app/view/payment/payment_screen.dart';
import '../../../apies/order_apies.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/order_controller.dart';
import '../../../model/countries_response.dart';
import '../../../model/order.dart';
import '../../../model/payment_method_response.dart';
import '../../../model/shipping_method_response.dart';
import '../../../services/app_imports.dart';
import '../../custom_widget/custom_text_form_field.dart';
import '../widget/custom_cart_product_item.dart';
import '../widget/stepper.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController cart = Get.find();
  OrderController orderController = Get.find();
  AuthController authController = Get.find();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  CountriesResponse? selectedCountries;
  String? selectedCountriesName;
  String? selectedCountriesCod;
  CountriesResponse? selectedCountriesState;
  String? selectedAddress;
  String? selectedAddressName;
  String? selectedPaymentMethods;
  String? selectedPaymentMethodsTitle;

  int currentStepperIndex = 0;

//-----------------confirm Page ----------------

  int? shippingGroupValue = 0;
  int? paymentGroupValue = 0;

  List anotherPaymentMethod = ["credit", "paypal"];
  String? selectedAnotherPaymentMethod;

  @override
  void initState() {
    OrderApies.orderApies.getShippingMethods();
    OrderApies.orderApies.getCountries();
    OrderApies.orderApies.getPaymentMethods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var shippingMethod = orderController.getShippingMethodsData!.value.listShippingMethodsResponse;
        var countries = orderController.getCountriesData!.value.listCountriesResponse;
        var payment = orderController.getPaymentMethodsData!.value.listPaymentMethodsResponse;
        var auth = authController.getCustomerInformationData!.value;
        double totalPrice() {
          double total = 0;
          cart.items.forEach((key, value) {
            total += (value.price! * value.quantity!);
          });
          return total;
        }

        List<Map<String, dynamic>> getCartItem() {
          List<Map<String, dynamic>> list = [];
          cart.items.forEach((key, value) {
            list.add({
              'product_id': value.id,
              'quantity': value.quantity!.toInt(),
            });
          });
          return list;
        }

        return Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            StepperRealEstates(currentStepperIndex),
            SizedBox(
              height: 24.h,
            ),
            currentStepperIndex == 0
                ? const SizedBox()
                : Row(
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      CustomButton(
                        title: 'السابق',
                        color: Colors.grey,
                        width: 70.w,
                        height: 40.h,
                        onTap: () {
                          setState(() {
                            currentStepperIndex -= 1;
                          });
                        },
                      ),
                    ],
                  ),
            SizedBox(
              height: 24.h,
            ),
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
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  'المنتجات',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.whiteColor,
                                ),
                                CustomText(
                                  'السعر',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.whiteColor,
                                ),
                                CustomText(
                                  'الكمية',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.whiteColor,
                                ),
                                CustomText(
                                  'المجموع',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.whiteColor,
                                ),
                                CustomText(
                                  '',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.whiteColor,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          cart.items.isEmpty
                              ? CustomText(
                                  'لم تقم بإضافة عناصر إلى السلة',
                                  fontSize: 15.sp,
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cart.items.length,
                                  itemBuilder: (context, index) {
                                    return CustomCartProductItem(
                                      imgUrl: cart.items.values.toList()[index].imgurl,
                                      price: cart.items.values.toList()[index].price.toString(),
                                      quantity: cart.items.values.toList()[index].quantity.toString(),
                                      total: (cart.items.values.toList()[index].quantity! *
                                              cart.items.values.toList()[index].price!)
                                          .toString(),
                                      onTapTrash: () {
                                        cart.removeItem(cart.items.values.toList()[index].id!);
                                        setState(() {});
                                      },
                                      onTapIncrease: () {
                                        cart.addItem(pdtid: cart.items.values.toList()[index].id.toString());
                                        setState(() {});
                                      },
                                      onTapDecrease: () {
                                        cart.removeSingleItem(cart.items.values.toList()[index].id.toString());
                                        setState(() {});
                                      },
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    currentStepperIndex == 0
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: AppColors.greyBorder)),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        'المجموع الكلي',
                                        fontSize: 16.sp,
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      CustomText(
                                        'انت تمتلك ${cart.items.length} منتجات بالسلة',
                                        fontSize: 14.sp,
                                        color: AppColors.hintGrey,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                CustomButton(
                                  onTap: () {
                                    setState(() => currentStepperIndex = 1);
                                  },
                                  height: 40.h,
                                  widget: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        'تأكيد',
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.whiteColor,
                                        fontSize: 16.sp,
                                      ),
                                      SizedBox(
                                        width: 14.w,
                                      ),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.whiteColor,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                CustomButton(
                                  onTap: () {},
                                  height: 40.h,
                                  title: 'استمرار عملية الشراء',
                                  titleColor: AppColors.hintGrey,
                                  color: AppColors.whiteColor,
                                  borderColor: AppColors.hintGrey,
                                ),
                              ],
                            ),
                          )
                        : currentStepperIndex == 1
                            ? Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(color: AppColors.greyBorder)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                          child: CustomText(
                                            'عنوان التسليم',
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 17.h,
                                        ),
                                        CustomTextFormField(
                                          controller: firstNameController,
                                          hintText: 'First Name',
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                          controller: lastNameController,
                                          hintText: 'Last Name',
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                          controller: emailController,
                                          hintText: 'email address',
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                          controller: phoneController,
                                          hintText: 'phone number',
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                          controller: address1Controller,
                                          hintText: 'address_1',
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                          controller: address2Controller,
                                          hintText: 'address_2',
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomTextFormField(
                                          controller: postcodeController,
                                          hintText: 'postcode',
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                                          child: Row(
                                            children: [
                                              CustomText(
                                                'country',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const Spacer(),
                                              countries != null
                                                  ? DropdownButton<CountriesResponse>(
                                                      focusColor: Colors.white,
                                                      value: selectedCountries,
                                                      //elevation: 5,
                                                      style: const TextStyle(color: Colors.white),
                                                      iconEnabledColor: Colors.black,
                                                      items: countries.map((value) {
                                                        return DropdownMenuItem<CountriesResponse>(
                                                          value: value,
                                                          child: CustomText(
                                                            value.name,
                                                            fontSize: 10.sp,
                                                          ),
                                                        );
                                                      }).toList(),
                                                      hint: CustomText(
                                                        "اختر المدينة",
                                                        fontSize: 10.sp,
                                                      ),
                                                      onChanged: (CountriesResponse? value) {
                                                        setState(() {
                                                          selectedCountries = value;
                                                          selectedCountriesName = value?.name;
                                                          selectedCountriesCod = value?.code;
                                                        });
                                                        print(selectedCountriesName);
                                                        print(selectedCountriesCod);
                                                      },
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(color: AppColors.greyBorder)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                          child: CustomText(
                                            'طريقة التوصيل',
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 17.h,
                                        ),
                                        shippingMethod == null
                                            ? const SizedBox()
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: shippingMethod.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Radio(
                                                            activeColor: Theme.of(context).primaryColor,
                                                            value: shippingMethod[index],
                                                            groupValue: shippingMethod[shippingGroupValue!],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                shippingGroupValue = index;
                                                                print(value?.title);
                                                                selectedAddress = value?.id;
                                                                selectedAddressName = value?.title;
                                                              });
                                                            },
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              padding: EdgeInsets.all(18.w),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8.0),
                                                                border:
                                                                    Border.all(width: 1.0, color: AppColors.greyBorder),
                                                              ),
                                                              child: CustomText(
                                                                shippingMethod[index].title!,
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.normal,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 25.h,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(color: AppColors.greyBorder)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                          child: CustomText(
                                            'طريقة الدفع',
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 17.h,
                                        ),
                                        payment == null
                                            ? const SizedBox()
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: payment.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Radio(
                                                              activeColor: Theme.of(context).primaryColor,
                                                              value: payment[index],
                                                              groupValue: payment[paymentGroupValue!],
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  paymentGroupValue = index;
                                                                  print(value?.id);
                                                                  selectedPaymentMethods = value?.id;
                                                                  selectedPaymentMethodsTitle = value?.title;
                                                                });
                                                              }),
                                                          Expanded(
                                                            child: Container(
                                                              padding: EdgeInsets.all(18.w),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8.0),
                                                                border:
                                                                    Border.all(width: 1.0, color: AppColors.greyBorder),
                                                              ),
                                                              child: CustomText(
                                                                payment[index].title!,
                                                                fontSize: 14.sp,
                                                                fontWeight: FontWeight.normal,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 25.h,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 19.0.w),
                                    child: CustomButton(
                                      onTap: () {
                                        setState(() => currentStepperIndex = 2);
                                      },
                                      height: 40.h,
                                      widget: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            'دفع ${totalPrice()} ر.س',
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.whiteColor,
                                            fontSize: 16.sp,
                                          ),
                                          SizedBox(
                                            width: 14.w,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward,
                                            color: AppColors.whiteColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 29.h,
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(
                                              'المنتجات',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14.sp,
                                            ),
                                            SizedBox(
                                              width: 22.w,
                                            ),
                                            CustomText(
                                              cart.items.length.toString(),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.sp,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CustomText(
                                              'القيمة النهائية',
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14.sp,
                                            ),
                                            SizedBox(
                                              width: 22.w,
                                            ),
                                            CustomText(
                                              totalPrice().toString(),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.sp,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 23.h,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(color: AppColors.greyBorder)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                'عنوان التسليم',
                                                fontSize: 16.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 29.h,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              'عنوان التسليم',
                                              fontSize: 14.sp,
                                              color: const Color(0xff6C6C6C),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            CustomText(
                                              selectedCountriesName,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(color: AppColors.greyBorder)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                'طريقة الدفع',
                                                fontSize: 16.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 29.h,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              'طريقة الدفع',
                                              fontSize: 14.sp,
                                              color: const Color(0xff6C6C6C),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                CustomText(
                                                  selectedPaymentMethodsTitle,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(color: AppColors.greyBorder)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(12.w),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF2F1F1), borderRadius: BorderRadius.circular(8.r)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                'طريقة  التوصيل',
                                                fontSize: 16.sp,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 29.h,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              'طريقة  التوصيل',
                                              fontSize: 14.sp,
                                              color: const Color(0xff6C6C6C),
                                              fontWeight: FontWeight.normal,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                CustomText(
                                                  selectedAddressName,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                // CustomText(
                                                //   DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                                //   fontSize: 14.sp,
                                                //   fontWeight: FontWeight.normal,
                                                // ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 29.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 19.0.w),
                                    child: CustomButton(
                                      onTap: () async {
                                        if (selectedPaymentMethods != null &&
                                            selectedPaymentMethodsTitle != null &&
                                            selectedCountriesName != null&&
                                            selectedCountriesCod!=null) {
                                          Order order = await OrderApies.orderApies.createOrder2(
                                            customer_id: auth.id.toString(),
                                            payment_method: selectedPaymentMethods!,
                                            payment_method_title: selectedPaymentMethodsTitle!,
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            addressOne: address1Controller.text,
                                            addressTwo: address2Controller.text,
                                            city: selectedCountriesName!,
                                            country: selectedCountriesCod!,
                                            state: "",
                                            postcode: postcodeController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            total: totalPrice().toString(),
                                            listProduct: getCartItem(),
                                          );
                                          print(order.id);
                                          print(order.orderKey);
                                          print(selectedPaymentMethodsTitle);
                                          Get.to(() => PaymentsScreen(
                                                orderId: order.id.toString(),
                                                orderKey: order.orderKey.toString(),
                                              ));
                                        }else{
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(content: Text('يرجى إكمال الحقول الناقصة')));
                                        }
                                      },
                                      height: 40.h,
                                      widget: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            'طلب',
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.whiteColor,
                                            fontSize: 16.sp,
                                          ),
                                          SizedBox(
                                            width: 14.w,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward,
                                            color: AppColors.whiteColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 54.h,
                                  ),
                                ],
                              )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget addRadioButtonPayment(
      {required int btnValue,
      required int groupValue,
      required String title,
      required List<PaymentMethodsResponse> lst,
      required void Function(PaymentMethodsResponse?)? onChange}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: lst[btnValue],
          groupValue: lst[groupValue],
          onChanged: onChange,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(width: 1.0, color: AppColors.greyBorder),
            ),
            child: CustomText(
              title,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }
}
