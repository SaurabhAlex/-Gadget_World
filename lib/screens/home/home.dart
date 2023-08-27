import 'package:flutter/material.dart';
import 'package:grocery_app/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:grocery_app/provider/app_provider.dart';
import 'package:grocery_app/screens/product_details/product_details.dart';
import 'package:grocery_app/screens/welcome/welcome.dart';
import 'package:provider/provider.dart';
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
    AppProvider appProvider = Provider.of<AppProvider>(context,listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async{
    setState(() {
      isLoading = true;
    });
    FirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirestoreHelper.instance.getCategories();
    productModelList = await FirestoreHelper.instance.getBestProducts();
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];
  void searchProducts(String value) {
    searchList = productModelList.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
    setState(() {  });
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
                  // const Text("Tech Junction", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  Align(
                    alignment: Alignment.center,
                      child: Image.asset("assets/images/applogo.png", scale: 2,)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: search,
                      onChanged: (String value) {
                        searchProducts(value);
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search_rounded),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          hintText: "Search..."
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Text("Categories", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
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
                              color:  Colors.white,
                              elevation: 14,
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
                  !isSearched()? const Text("Best Products", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
                  :SizedBox.fromSize(),
                  const SizedBox(height: 12,),
                  search.text.isNotEmpty && searchList.isEmpty? const Center(child: Text("No Product Found"),):
                      searchList.isNotEmpty?
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: GridView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: searchList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                childAspectRatio: 0.8
                            ),
                            itemBuilder: (context, index){
                              ProductModel singleProduct = searchList[index];
                              return Container(
                                decoration: BoxDecoration(
                                    color:  Colors.purpleAccent.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.network(singleProduct.image, height: 120,width: 80,),
                                    Text( singleProduct.name,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    Text("Price: \u{20B9}${singleProduct.price}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                      ),),
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
                        ),
                      ):
                  productModelList.isEmpty? const Center(
                    child: Text("Best Products is Empty"),
                  ):
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: GridView.builder(
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
                                color:  Colors.purpleAccent.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(singleProduct.image, height: 120,width: 80,),
                                Text( singleProduct.name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),),
                                Text("Price: \u{20B9}${singleProduct.price}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  ),),
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
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }


  bool isSearched(){
    if(search.text.isNotEmpty && searchList.isEmpty){
      return true;
    }else if(search.text.isEmpty && searchList.isNotEmpty){
      return false;
    }else if(searchList.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
}

