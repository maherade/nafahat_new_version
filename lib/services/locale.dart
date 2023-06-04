import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "personal_information_value": "المعلومات الشخصية",
          "favourite_value": "المفضلة",
          "my_order_value": "طلباتي",
          "gift_card_value": "بطاقات الهدايا",
          "whole_sale_value": "البيع بالجملة",
          "who_us_value": "من نحن",
          "privacy_policy_value": "سياسة الخصوصية",
          "terms_and_condition_value": "الشروط والأحكام",
          "common_question_value": "الأسئلة الشائعة",
          "contact_us_value": "اتصل بنا",
          "logout_value": "تسجيل الخروج",
          "delete_account_value": "حذف الحساب",
          "guest_value": "ضيف",
          "sign_in_to_use_all_feature_value": "قم بتسجيل الدخول لتتمتع بجميع مزايا التطبيق",
          "login_value": "تسجيل الدخول",
          "order_by_popularity_value": "ترتيب حسب الشهرة",
          "order_by_rating_value": "ترتيب حسب معدل التقييم",
          "order_by_recent_value": "ترتيب حسب الأحدث",
          "order_by_min_to_height_price_value": "ترتيب حسب الأدنى سعرا للأعلى",
          "order_by_height_to_min_price_value": "ترتيب حسب الأعلى سعرا للأدنى",
          "order_default_value": "الترتيب الإفتراضي",
          "gift_package_value": "بكجات نفحات",
          "discover_gift_package_value": "استكشاف بكجات نفحات",
          "no_item_found_value": "لا توجد عناصر",
          "last_seen_value": "أخر المشاهدات",
          "shop_by_brand_value": "تسوق حسب الماركات التجارية",
          "search_by_brand_value": "ابحث في الماركات",
          "search_by_product_value": "ابحث عن منتج..",
          "select_from_category_value": "اختر من الأقسام",
          "famous_brand_value": "أشهر الماركات",
          "shop_by_category_value": "تسوق حسب الأقسام",
          "top_sale_value": "الأفضل مبيعا",
          "view_all_value": "عرض الكل",
//
          "top_sale_in_value": "الأفضل مبيعا في ",
          "no_item_found_with_you_choice_value": "لا توجد منتجات تتوافق مع اختيارك.",
          "famous_care_product_value": "أشهر منتجات قسم العناية",
          "top_offers_value": "أفضل العروض",
          "product_under_20_value": "منتجات تحت 20 ريال",
          "recently_arrive_value": "وصل حديثا",
          "article_value": "المقالات",
          "makeup_category_value": "قسم المكياج",
          "cart_value": "سلة التسوق",
          "previous_value": "السابق",
          "product_value": "المنتجات",
          "price_value": "السعر",
          "quantity_value": "الكمية",
          "total_value": "المجموع",
          "you_not_added_item_in_cart_value": "لم تقم بإضافة عناصر إلى السلة",
          "total_price_value": "المجموع الكلي",
          "you_have_value": "انت تمتلك ",
          "item_in_cart_value": " منتجات بالسلة",
          "please_add_item_in_cart_value": "يرجى إدخال منتجات إلى السلة للمتابعة",
          "confirm_value": "تأكيد",
          "continue_buy_process_value": "استمرار عملية الشراء",
          "delivery_location_value": "عنوان التسليم",
          "first_name_value": "الإسم الأول",
          "last_name_value": "الإسم الأخير",
          "email_value": "البريد الإلكتروني",
          "phone_value": "رقم الهاتف",
          "address1_value": "عنوان ١",
          "address2_value": "عنوان 2",
          "postal_code_value": "الرمز البريدي",
          "select_countries_value": "اختر الدولة",
          "city_value": "المدينة",
          "delivery_method_value": "طريقة التوصيل",
          "edit_location_value": "تعديل العنوان",
          "payment_method_value": "طريقة الدفع",
          "email_address_not_valid_value": "البريد الالكتروني غير صالح",
          "please_fill_all_information_value": "يرجى إدخال كافة المعلومات",
          "pay_value": "دفع ",
          "sar_value": " ر.س",
          "final_price_value": "القيمة النهائية",
          "you_own_value": "أنت تمتلك ",
          "product_in_cart_value": "منتجات بالسلة",
          "total_orders_value": "مجموع الطلبات",
          "delivery_cost_value": "تكاليف الشحن",
          "discount_value": "مبلغ الخصم",
          "total_amount_value": "المبلغ الكلي",
          "coupon_value": "كوبون الخصم",
          "enter_coupon_value": "أدخل الكوبون",
          "use_value": "استخدام",
          "you_havee_value": "لديك ",
          "point_value": " نقطة ",
          "worth_value": "بقيمة ",
//
          "you_can_use_point_value": " يمكنك استخدام النقاط وخصم سعر النقاط من قيمة طلبك الإجمالي",
          "enter_points_value": "قم بإدخال النقاط",
          "you_dont_have_enough_point_value": "ليس لديك نقاط كافية",
          "order_value": "طلب",
          "here_some_question_value": "هنا بعض الأسئلة التي قام المستخدمون بالاستفسار عنها",
          "no_favourite_value": "لا توجد مفضلة",
          "you_dont_have_favorite_yet_value": "ليس لديك منتجات مفضلة بعد",
          "back_to_store_value": "العودة إلى المتجر",
          "shop_from_category_value": "تسوق من قسم ",
          "no_product_found_value": "لا توجد منتجات",
          "frz_by_value": "فرز حسب",
          "brands_value": "الماركات",
          "category_value": "القسم",
          "search_by_category_value": "بحث في الأقسام",
          "please_select_category_value": "يرجى اختيار القسم",
          "view_result_value": "عرض النتائج",
          "giftt_card_value": "بطاقة الهدايا",
          "send_credit_value": "إهداء الرصيد",
          "sended_gift_value": "الهدايا المرسلة",
          "no_gift_value": "لا توجد هدايا",
          "no_gift_found_yet_value": "ليس لديك هدايا مرسلة بعد",
          "send_first_gift_value": "أرسل هديتك الأولى",
          "complete_value": "مكتمل",
          "cancelled_value": "ملغي",
          "product_name_value": "اسم المنتج",
          "total_pricee_value": "السعر الكلي",
          "delev_loca_value": "مكان التوصيل",
          "delev_date_value": "تاريخ التوصيل",
          "delev_time_value": "وقت التوصيل",
          "re_order_value": "اعادة الطلب",
          "SAR_value": " ريال",
          "balance_value": "قيمة الرصيد",
          "enter_another_value": "أدخل قيمة أخرى",
          "please_enter_another_value": "قم بإدخال قيمة أخرى",
          "enter_phone_for_reciever_value": "أدخل رقم الجوال المستلم",
          "enter_active_phone_value": "أدخل رقم هاتف فعال",
          "enter_phone_(optional)_value": "'أدخل البريد الإلكتروني المستلم (اختياري)'",
          "another_value_is_the_recipients_email_value": "قيمة أخرى البريد الإلكتروني المستلم",
          "complete_order_value": "إتمام الطلب",
          "if_have_problem_value": "اذا واجهتك أي مشكلة , قم بالاتصال بنا",
          "emaill_value": "الايميل",
          "enter_your_email_value": "قم بإدخال الايميل الخاص بك",
          "notes_value": "الملاحظات",
          "enter_your_notes_value": "قم بإدخال ملاحظاتك , لنقوم بحلها",
          "send_value": "ارسال",
          "my_orders": "طلباتي",
          "current_orders": "الطلبات الحالية",
          "previous_orders": "الطلبات السابقة",
          "no_orders_available": "لا تتوفر طلبات",
          "pending_value": "في الإنتظار",
          "processing_value": "قيد المعالجة",
          "on_hold_value": "قيد الإنتظار",
          "rejected_value": "مرفوض",
          //

          "cancelled_order_value": "الغاء الطلب",
          "all_value": "الكل",
          "remaining_points_value": "النقاط المتبقية",
          "used_points_value": "النقاط المستخدمة",
          "expired_points_value": "النقاط المنتهية",
          "my_points_value": "نقاطي",
          "total_points_value": "مجموع النقاط الكلي",
          "expired_total_points_value": "مجموع النقاط التي\n انتهت صلاحيتها",
          "points_date_value": "تاريخ النقاط",
          "equal_to_value": "والذي يعادل ",
          "redeemed_points_value": "لقد قمنا باسترداد ",
          "points_discount_value": " نقطة مقابل خصم",
          "points_expired_value": "تم إنتهاء صلاحية",
          "equal_to_2_value": "والتي تعادل",
          "got_points_value": "لقد حصلت على",
          "pending_points_value": "نقاط معلقة ",
          "pending_equal_to_value": " نقطة والتي تعادل",
          "unclaimed_points_value": "نقاط غير المطالب بها ",
          "used_value": "لقد استخدمت ",
          "remove_from_favourite_value": "تمت الحذف من المفضلة بنجاح",
          "add_from_favourite_value": " تمت الإضافة إلى المفضلة بنجاح",
          "overview_value": "نظرة عامة",
          "rating_value": "التقييمات",
          "add_comment_value": "أضف تعليق",
          "add_rate_value": "أضف تقييم",
          "how_match_rate_value": "كم تقييمك للمنتج",
          "no_comment_value": "لا توجد تعليقات",
          "related_product_value": "منتجات مشابهة",
          "count_value": "العدد",
          "enter_email_value": "قم بإدخال البريد الإلكتروني",
          "name_value": "الإسم",
          "enter_name_value": "قم بإدخال الإسم",
          "password_value": "كلمة المرور",
          "enter_password_value": "قم بإدخال كلمة المرور",
          "address_value": "عنوان السكن",
          "enter_address_value": "قم بإدخال عنوان السكن",
          "language_value": "اللغة",
          "save_value": "حفظ",
          "select_lang_value": "اختر اللغة",
          "search_value": "بحث",
          "host_value": "المضيف :",
          "street_value": "الشارع :",
          "point_name_value": "اسم النقطة :",
          "details_value": "تفاصيل :",
          "select_point_value": "اختر النقطة",
          "shop_from_brand_value": "تسوق من ماركة ",
          "hardware_value": "الأجهزة",
          "product_less_than_value": "منتجات أقل من 20 ريال",
          "enter_client_name_value": "قم بإدخال اسم العميل",
          "client_name_value": "اسم العميل",
          "client_name_cannot_empty_value": "حقل اسم العميل لا يمكن أن يكون فارغ",
          "enter_organization_name_value": "قم بإدخال اسم المؤسسة",
          "organization_name_value": "اسم المؤسسة",
          "organization_name_cannot_empty_value": "حقل اسم المؤسسة لا يمكن أن يكون فارغ",
          "enter_organization_address_value": "قم بإدخال عنوان المؤسسة",
          "organization_address_value": "عنوان المؤسسة",
          "organization_address_cannot_empty_value": "حقل عنوان المؤسسة لا يمكن أن يكون فارغ",
          "enter_email_address_value": "قم بإدخال البريد الالكتروني",
          "email_address_value": "البريد الالكتروني",
          "email_address_cannot_empty_value": "حقل البريد الالكتروني لا يمكن أن يكون فارغ",
          "enter_phone_number_value": "قم بإدخال رقم الجوال",
          "phone_number_value": "رقم الجوال",
          "phone_number_cannot_empty_value": "حقل رقم الجوال لا يمكن أن يكون فارغ",
          "send_request_value": "ارسال الطلب",
          "add_successful_to_cart_value": "تمت إضافة المنتج إلى السلة",
          "continue_buy_value": "متابعة الشراء",
          "go_to_cart_value": "الذهاب للسلة",
          "are_you_sure_delete_account_value": "هل أنت متأكد من حذف الحساب؟",
          "deleted_dialog_value": "سيتم حذف حسابك خلال ٣٠ يوم إذا لم تقم بتسجيل الدخول مرة أخرى",
          "cancel_value": "إلغاء",
          "your_order_complete_value": "تم إتمام طلبك بنجاح",
          "go_home_value": "الذهاب للرئيسية",
          "go_order_screen_value": "الذهاب لصفحة الطلبات",
          "are_you_sure_cancel_order_value": "هل أنت متأكد من إلغاء الطلب؟",
          "back_value": "رجوع",
          "cancel_order_value": "إلغاء الطلب",
          "repeat_order_value": "هل أنت متأكد من إعادة الطلب؟",
          "rate_add_successful_value": "تم إضافة التقييم بنجاح",
          "check_entered_data_value": "يرجى التأكد من المعلومات المدخلة",
          "login_successful_value": "تم تسجيل الدخول بنجاح",
          "register_successful_value": "تم التسجيل بنجاح",
          "coupon_active_value": "الكوبون فعال - قيمة الكوبون : ",
          "bottom_nav_home_value": "الرئيسية",
          "bottom_nav_category_value": "الأقسام",
          "bottom_nav_brand_value": "الماركات",
          "bottom_nav_gift_package_value": "بكجات نفحات",
          "bottom_nav_account_value": "حسابي",
          "complete_buy_process_value": "اتمام عملية الشراء",
          "add_to_cart_value": "أضف إلي السلة",
          "you_will_have_value": "ستحصل على ",
          "when_buy_this_product_value": " نقطة عند القيام بشراء هذا المنتج",
          "free_shipping_value": "شحن مجاني",
          "free_and_fast_shipping_value": "شحن سريع مجاني للطلبات",
          "date_delivery_expected_value": "تاريخ التوصيل المحتمل في ",
          "pay_on_delivery_value": "خدمة الدفع عند الإستلام",
          "know_more_value": "تعرف أكثر",
          "return_policy_value": "سياسة الإرجاع",
          "cannot_return_value": "إرحاع أو استبدال المنتجات غير ممكن",
          "from_the_market_value":"الطلبات في منطقة الرياض يمكنك استلامها من المعرض",

          "care_in_ramadan_value":"عنايتك في الصيف",
          "top_lenses_product_value":"أفضل منتجات قسم العدسات",
          "top_ramadan_offer_product_value":"عروض الصيف",
          "top_makeup_product_value":"أفضل منتجات قسم المكياج",
          "top_devices_product_value":"أفضل منتجات قسم الأجهزة",
          "top_azafer_product_value":"أفضل منتجات قسم الأظافر",
          "top_perfume_product_value":"أفضل منتجات قسم العطور",
          "send_message_value":"هل أنت متأكد من الطلب ؟ سيتم إرسال رسالة نصية تحتوي على كود التحقق إلى رقم الهاتف :",

          "cod_value":"رسوم إضافية"


        },
        "en": {
          "personal_information_value": "Personal Information",
          "favourite_value": "Favorites",
          "my_order_value": "My Orders",
          "gift_card_value": "Gift Cards",
          "whole_sale_value": "Wholesale",
          "who_us_value": "About Us",
          "privacy_policy_value": "Privacy Policy",
          "terms_and_condition_value": "Terms and Conditions",
          "common_question_value": "Frequently Asked Questions",
          "contact_us_value": "Contact Us",
          "logout_value": "Log out",
          "delete_account_value": "Delete Account",
          "guest_value": "Guest",
          "sign_in_to_use_all_feature_value": "Sign in to use all features",
          "login_value": "Log in",
          "order_by_popularity_value": "Sort by Popularity",
          "order_by_rating_value": "Sort by Rating",
          "order_by_recent_value": "Sort by Recent",
          "order_by_min_to_height_price_value": "Sort by Price: Low to High",
          "order_by_height_to_min_price_value": "Sort by Price: High to Low",
          "order_default_value": "Default Sort",
          "gift_package_value": "Nafahat Packages",
          "discover_gift_package_value": "Discover Nafahat Packages",
          "no_item_found_value": "No Items Found",
          "last_seen_value": "Last Seen",
          "shop_by_brand_value": "Shop by Brand",
          "search_by_brand_value": "Search by Brand",
          "search_by_product_value": "Search for a Product...",
          "select_from_category_value": "Select from Categories",
          "famous_brand_value": "Famous Brands",
          "shop_by_category_value": "Shop by Category",
          "top_sale_value": "Top Sales",
          "view_all_value": "View All",
          //
          "top_sale_in_value": "Bestselling in",
          "no_item_found_with_you_choice_value": "No items found that match your selection.",
          "famous_care_product_value": "Famous care products",
          "top_offers_value": "Top offers",
          "product_under_20_value": "Products under 20 SAR",
          "recently_arrive_value": "Recently arrived",
          "article_value": "Articles",
          "makeup_category_value": "Makeup category",
          "cart_value": "Shopping cart",
          "previous_value": "Previous",
          "product_value": "Products",
          "price_value": "Price",
          "quantity_value": "Quantity",
          "total_value": "Total",
          "you_not_added_item_in_cart_value": "You have not added any items to your cart.",
          "total_price_value": "Total Price",
          "you_have_value": "You have",
          "item_in_cart_value": " items in your cart",
          "please_add_item_in_cart_value": "Please add items to your cart to continue",
          "confirm_value": "Confirm",
          "continue_buy_process_value": "Continue buying process",
          "delivery_location_value": "Delivery location",
          "first_name_value": "First name",
          "last_name_value": "Last name",
          "email_value": "Email",
          "phone_value": "Phone",
          "address1_value": "Address 1",
          "address2_value": "Address 2",
          "postal_code_value": "Postal code",
          "select_countries_value": "Select country",
          "city_value": "City",
          "delivery_method_value": "Delivery method",
          "edit_location_value": "Edit location",
          "payment_method_value": "Payment method",
          "email_address_not_valid_value": "Email address is not valid",
          "please_fill_all_information_value": "Please fill in all information",
          "pay_value": "Pay",
          "sar_value": " SAR",
          "final_price_value": "Final price",
          "you_own_value": "You own",
          "product_in_cart_value": "products in your cart",
          "total_orders_value": "Total orders",
          "delivery_cost_value": "Delivery cost",
          "discount_value": "discount amount",

          "total_amount_value": "Total amount",
          "coupon_value": "Discount coupon",
          "enter_coupon_value": "Enter coupon",
          "use_value": "Use",
          "you_havee_value": "You have ",
          "point_value": " points ",
          "worth_value": " worth ",
          //
          "you_can_use_point_value": "You can use points and deduct the point value from your total order value",
          "enter_points_value": "Enter points value",
          "you_dont_have_enough_point_value": "You don't have enough points",
          "order_value": "Order",
          "here_some_question_value": "Here are some questions that users have asked",
          "no_favourite_value": "No favorites",
          "you_dont_have_favorite_yet_value": "You don't have any favorite products yet",
          "back_to_store_value": "Back to store",
          "shop_from_category_value": "Shop from category",
          "no_product_found_value": "No products found",
          "frz_by_value": "Sort by",
          "brands_value": "Brands",
          "category_value": "Category",
          "search_by_category_value": "Search by category",
          "please_select_category_value": "Please select a category",
          "view_result_value": "View results",
          "giftt_card_value": "Gift card",
          "send_credit_value": "Send credit",
          "sended_gift_value": "Sent gifts",
          "no_gift_value": "No gifts",
          "no_gift_found_yet_value": "You haven't sent any gifts yet",
          "send_first_gift_value": "Send your first gift",
          "complete_value": "Complete",
          "cancelled_value": "Cancelled",
          "product_name_value": "Product name",
          "total_pricee_value": "Total price",
          "delev_loca_value": "Delivery location",
          "delev_date_value": "Delivery date",
          "delev_time_value": "Delivery time",
          "re_order_value": "Re-order",
          "SAR_value": " SAR ",
          "balance_value": "Balance value",
          "enter_another_value": "Enter another value",
          "please_enter_another_value": "Please enter another value",
          "enter_phone_for_reciever_value": "Enter recipient's phone number",
          "enter_active_phone_value": "Enter active phone number",
          "enter_phone_(optional)_value": "Enter recipient's email (optional)",
          "another_value_is_the_recipients_email_value": "Another value is the recipient's email",
          "complete_order_value": "Complete order",
          "if_have_problem_value": "If you have any problems, contact us",
          "emaill_value": "Email",
          "enter_your_email_value": "Enter your email",
          "notes_value": "Notes",
          "enter_your_notes_value": "Enter your notes so we can help you",
          "send_value": "Send",
          "my_orders": "My orders",
          "current_orders": "Current orders",
          "previous_orders": "Previous orders",
          "no_orders_available": "No orders available",
          "pending_value": "Pending",
          "processing_value": "Processing",
          "on_hold_value": "On hold",
          "rejected_value": "Rejected",
          //
          "cancelled_order_value": "Cancelled Order",
          "all_value": "All",
          "remaining_points_value": "Remaining Points",
          "used_points_value": "Used Points",
          "expired_points_value": "Expired Points",
          "my_points_value": "My Points",
          "total_points_value": "Total Points",
          "expired_total_points_value": "Total Expired Points",
          "points_date_value": "Points Date",
          "equal_to_value": "Equals",
          "redeemed_points_value": "We have redeemed",
          "points_discount_value": "points for discount",
          "points_expired_value": "Points Expired",
          "equal_to_2_value": "which equals",
          "got_points_value": "You have earned",
          "pending_points_value": "Pending Points",
          "pending_equal_to_value": "points which equals",
          "unclaimed_points_value": "Unclaimed Points",
          "used_value": "You have used",
          "remove_from_favourite_value": "Successfully removed from favorites",
          "add_from_favourite_value": "Successfully added to favorites",
          "overview_value": "Overview",
          "rating_value": "Ratings",
          "add_comment_value": "Add comment",
          "add_rate_value": "Add rating",
          "how_match_rate_value": "How many stars would you rate this product?",
          "no_comment_value": "No comments",
          "related_product_value": "Related Products",
          "count_value": "Count",
          "enter_email_value": "Enter Email",
          "name_value": "Name",
          "enter_name_value": "Enter Name",
          "password_value": "Password",
          "enter_password_value": "Enter Password",
          "address_value": "Address",
          "enter_address_value": "Enter Address",
          "language_value": "Language",
          "save_value": "Save",
          "select_lang_value": "Select Language",
          "search_value": "Search",
          "host_value": "Host:",
          "street_value": "Street:",
          "point_name_value": "Point Name:",
          "details_value": "Details:",
          "select_point_value": "Select Point",
          "shop_from_brand_value": "Shop from brand",
          "hardware_value": "Hardware",
          "product_less_than_value": "Products less than 20 SAR",
          "enter_client_name_value": "Enter client name",
          "client_name_value": "Client name",
          "client_name_cannot_empty_value": "Client name field cannot be empty",
          "enter_organization_name_value": "Enter organization name",
          "organization_name_value": "Organization name",
          "organization_name_cannot_empty_value": "Organization name field cannot be empty",
          "enter_organization_address_value": "Enter organization address",
          "organization_address_value": "Organization address",
          "organization_address_cannot_empty_value": "Organization address field cannot be empty",
          "enter_email_address_value": "Enter email address",
          "email_address_value": "Email address",
          "email_address_cannot_empty_value": "Email address field cannot be empty",
          "enter_phone_number_value": "Enter phone number",
          "phone_number_value": "Phone number",
          "phone_number_cannot_empty_value": "Phone number field cannot be empty",
          //
          "send_request_value": "Send Request",
          "add_successful_to_cart_value": "Product added to cart successfully",
          "continue_buy_value": "Continue Shopping",
          "go_to_cart_value": "Go to Cart",
          "are_you_sure_delete_account_value": "Are you sure you want to delete your account?",
          "deleted_dialog_value": "Your account will be deleted in 30 days if you do not log in again",
          "cancel_value": "Cancel",
          "your_order_complete_value": "Your order has been completed successfully",
          "go_home_value": "Go to Home",
          "go_order_screen_value": "Go to Order Screen",
          "are_you_sure_cancel_order_value": "Are you sure you want to cancel the order?",
          "back_value": "Back",
          "cancel_order_value": "Cancel Order",
          "repeat_order_value": "Are you sure you want to repeat the order?",
          "rate_add_successful_value": "Rating added successfully",
          "check_entered_data_value": "Please check the entered information",
          "login_successful_value": "Login successful",
          "register_successful_value": "Registration successful",
          "coupon_active_value": "Coupon is active - Coupon Value: ",
          "bottom_nav_home_value": "Home",
          "bottom_nav_category_value": "Category",
          "bottom_nav_brand_value": "Brands",
          "bottom_nav_gift_package_value": "Nafahat Package",
          "bottom_nav_account_value": "My Account",
          "complete_buy_process_value": "Complete Purchase",
          "add_to_cart_value": "Add to cart",
          "you_will_have_value": "You will get",
          "when_buy_this_product_value": " point(s) when purchasing this product",
          "free_shipping_value": "Free shipping",
          "free_and_fast_shipping_value": "Fast and free shipping for orders",
          "date_delivery_expected_value": "Expected delivery date on",
          "pay_on_delivery_value": "Cash on delivery service",
          "know_more_value": "Learn more",
          "return_policy_value": "Return policy",
          "cannot_return_value": "Returning or exchanging products is not possible",
          "from_the_market_value":"Orders in the Riyadh region can be collected from the Market",

          "care_in_ramadan_value": "Your Care During Summer",
          "top_lenses_product_value": "Top Products in Lenses Category",
          "top_ramadan_offer_product_value": "Summer Offers",
          "top_makeup_product_value": "Top Products in Makeup Category",
          "top_devices_product_value": "Top Products in Devices Category",
          "top_azafer_product_value": "Top Products in Nails Category",
          "top_perfume_product_value": "Top Products in Perfume Category",
          "cod_value":"charge value"
        },
      };
}
