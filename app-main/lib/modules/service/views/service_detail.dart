import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/common/widgets/base_widget.dart';

class ServiceDetail extends StatelessWidget {
  const ServiceDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Get.arguments["SERVICE"];
    return BaseWidget(
      title: "Price List",
      isMargin: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Image.asset("assets/images/service/spa1.jpg"),
            Container(
              margin: const EdgeInsets.all(15),
              child: const BaseText(
                text:
                    "Hàng ngày, da mặt anh phải tiếp xúc với khói bụi, tia UV, tia cực tím,... khiến da sạm đi, xỉn màu, tích tụ các độc tố ẩn sâu trong da từ đó gây ra mụn nhọt, sạm da và các bệnh nguy hiểm cho da mặt. Thấy được điều này, 30Shine đã nghiên cứu và phát triển ra combo mặt nạ tẩy da chết sủi bọt trắng sáng giúp anh sẽ có một làn da sạch khỏe, trắng sáng tức thì",
                centerText: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: BaseText(
                    text: "find-salon-near".tr,
                    isTile: true,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF337835),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: BaseText(
                    text: "book-now".tr,
                    isTile: true,
                  ),
                ),
              ],
            ),
            Html(
              data: """<div>
          <h1>Demo Page</h1>
          <p>This is a fantastic product that you should buy!</p>
          <h3>Features</h3>
          <ul>
            <li>It actually works</li>
            <li>It exists</li>
            <li>It doesn't cost much!</li>
          </ul>
          <!--You can pretty much put any html in here!-->
        </div>""",
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF337835),
                borderRadius: BorderRadius.circular(5),
              ),
              child: BaseText(
                text: "book-now".tr,
                isTile: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
