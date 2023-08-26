import 'package:flutter/material.dart';
import '../../constants/routes.dart';
import '../../firebase_helper/firestore_helper/firestore_helper.dart';
import '../../model/category_model/category_model.dart';
import '../../model/product_model/product_model.dart';
import '../product_details/product_details.dart';

class CategoryViewScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryViewScreen({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<CategoryViewScreen> createState() => _CategoryViewScreenState();
}

class _CategoryViewScreenState extends State<CategoryViewScreen> {
  bool isLoading = false;
  List<ProductModel> productModelList = [];
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async{
    setState(() {
      isLoading = true;
    });
    productModelList = await FirestoreHelper.instance.getCategoryViewProducts(widget.categoryModel.id);
    productModelList.shuffle();

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: isLoading? Center(
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      ):
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackButton(),
                  const SizedBox(width: 10,),
                  Text(widget.categoryModel.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                ],
              ),
              const SizedBox(height: 10,),
              productModelList.isEmpty? const Center(
                child: Text("productModelList is Empty"),
              ):
              GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: productModelList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.8
                  ),
                  itemBuilder: (context, index){
                    ProductModel singleProduct = productModelList[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(singleProduct.image, height: 120,width: 80,),
                          Text( singleProduct.name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          Text("Price \u{20B9}${singleProduct.price}"),
                          OutlinedButton(
                              onPressed: () {
                                Routes.instance.push(ProductDetails(singleProduct: singleProduct), context);
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                ),
                              ),
                              child: const Text("Buy", style:  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)
                          ),
                          const SizedBox(height: 5,),
                        ],
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
