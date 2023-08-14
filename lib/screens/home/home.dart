import 'package:flutter/material.dart';
import 'package:grocery_app/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:grocery_app/screens/product_details/product_details.dart';
import 'package:grocery_app/screens/welcome/welcome.dart';
import '../../constants/routes.dart';
import '../../model/category_model/category_model.dart';
import '../../model/product_model/product_model.dart';
import '../category_view/category_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  bool isLoading = false;
  List<CategoryModel> categoriesList = [];
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
    categoriesList = await FirestoreHelper.instance.getCategories();
    productModelList = await FirestoreHelper.instance.getBestProducts();
    productModelList.shuffle();

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading? Center(
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      ):
      SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Gadget World", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Search..."
                    ),
                  ),
                ),
                const SizedBox(height: 8,),
                const Text("Items", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                categoriesList.isEmpty? const Center(
                  child: Text("Categories is Empty"),
                ):
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoriesList.map((e) =>  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: () {
                          Routes.instance.push(CategoryViewScreen(categoryModel: e), context);
                        } ,
                        child: Card(
                          color: Colors.white,
                          elevation: 13,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(e.image)
                                ),
                                Text(
                                  e.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                      ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ).toList()
                  ),
                ),
                const SizedBox(height: 10,),
                const Text("Best Products", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                const SizedBox(height: 12,),
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
                          color: Colors.purpleAccent.withOpacity(0.3),
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
                            Text("Price \$${singleProduct.price}"),
                            OutlinedButton(
                                onPressed: () {
                                  Routes.instance.push(ProductDetails(singleProduct: singleProduct), context);
                                },
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
      )
    );
  }
}


// List<ProductModel> bestProducts = [
//   ProductModel(
//       image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
//       id: '1',
//       name: "Laptop",
//       price: "100",
//       desc: "This is the best Laptop",
//       status: "pending",
//       isFavourite: false
//   ),
//   ProductModel(
//       image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
//       id: '2',
//       name: "Laptop",
//       price: "100",
//       desc: "This is the best Laptop",
//       status: "pending",
//       isFavourite: false
//   ),
//   ProductModel(
//       image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
//       id: '3',
//       name: "Laptop",
//       price: "100",
//       desc: "This is the best Laptop",
//       status: "pending",
//       isFavourite: false
//   ),
//   ProductModel(
//       image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
//       id: '4',
//       name: "Laptop",
//       price: "100",
//       desc: "This is the best Laptop",
//       status: "pending",
//       isFavourite: false
//   ),
//   ProductModel(
//       image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
//       id: '5',
//       name: "Laptop",
//       price: "100",
//       desc: "This is the best Laptop",
//       status: "pending",
//       isFavourite: false
//   ),
//   ProductModel(
//       image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
//       id: '6',
//       name: "Laptop",
//       price: "100",
//       desc: "This is the best Laptop",
//       status: "pending",
//       isFavourite: false
//   )
// ];
