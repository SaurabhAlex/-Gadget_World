import 'package:flutter/material.dart';
import 'package:grocery_app/screens/welcome/welcome.dart';
import '../../constants/routes.dart';
import '../../model/product_model/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Routes.instance.push(const WelcomeScreen(), context);
        }, icon:  const Icon(Icons.arrow_back_ios),)

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
              const Text("Items", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoriesList.map((e) =>  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 13,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.network(e)
                      ),
                    ),
                  ),
                  ).toList()
                ),
              ),
              const SizedBox(height: 5,),
              const Text("Best Products", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              GridView.builder(
                shrinkWrap: true,
                  itemCount: bestProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20
                  ),
                  itemBuilder: (context, index){
                  ProductModel singleProduct = bestProducts[index];
                    return Container(
                      color: Colors.red.withOpacity(0.5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(singleProduct.image, scale: 10,),
                          const SizedBox(height: 5,),
                          Text( singleProduct.name,
                          style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                          ),),
                          Text("Price \$${singleProduct.price}"),
                          const SizedBox(height: 5,),
                          OutlinedButton(
                              onPressed: () {},
                              child: const Text("Buy")
                          )
                        ],
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      )
    );
  }
}


List<String> categoriesList = [
  "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
  "https://icon-library.com/images/laptop-vector-icon/laptop-vector-icon-3.jpg",
  "https://img.freepik.com/premium-vector/modern-laptop-with-empty-screen-isolated_95169-1371.jpg",
  "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgfGWx5ZT04FIt5syXlND32MYZUPYp-eUE0g&usqp=CAU"

];

List<ProductModel> bestProducts = [
  ProductModel(
      image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
      id: '1',
      name: "Laptop",
      price: "100",
      desc: "This is the best Laptop",
      status: "pending",
      isFavourite: false
  ),
  ProductModel(
      image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
      id: '2',
      name: "Laptop",
      price: "100",
      desc: "This is the best Laptop",
      status: "pending",
      isFavourite: false
  ),
  ProductModel(
      image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
      id: '3',
      name: "Laptop",
      price: "100",
      desc: "This is the best Laptop",
      status: "pending",
      isFavourite: false
  ),
  ProductModel(
      image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
      id: '4',
      name: "Laptop",
      price: "100",
      desc: "This is the best Laptop",
      status: "pending",
      isFavourite: false
  ),
  ProductModel(
      image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
      id: '5',
      name: "Laptop",
      price: "100",
      desc: "This is the best Laptop",
      status: "pending",
      isFavourite: false
  ),
  ProductModel(
      image: "https://w7.pngwing.com/pngs/14/113/png-transparent-laptop-netbook-computer-pink-laptop-electronics-electronic-device-laptop-vector.png",
      id: '6',
      name: "Laptop",
      price: "100",
      desc: "This is the best Laptop",
      status: "pending",
      isFavourite: false
  )
];
