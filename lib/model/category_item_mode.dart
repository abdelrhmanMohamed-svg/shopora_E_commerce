class CategoryItemModel {
  final String id;
  final String name;
  final String imgUrl;
  final int productsCount;

  CategoryItemModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.productsCount,
  });
}

List<CategoryItemModel> dummyCategories = [
  CategoryItemModel(
    id: "1",
    name: "New Arrivals",
    imgUrl:
        "https://img.freepik.com/free-photo/woman-wearing-blank-shirt_23-2149347516.jpg?t=st=1760912729~exp=1760916329~hmac=f3e43f42f3ce9fde0078bbb2be3784f41a716e3cb55b9cf153cbe8c1943c8460&w=1480",
    productsCount: 208,
  ),
  CategoryItemModel(
    id: "2",
    name: "Clothes",
    imgUrl:
        "https://images.unsplash.com/photo-1740650874524-4f57a78e5878?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=798",
    productsCount: 300,
  ),
  CategoryItemModel(
    id: "3",
    name: "Bags",
    imgUrl:
        "https://images.unsplash.com/photo-1575032617751-6ddec2089882?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=764",
    productsCount: 500,
  ),
  CategoryItemModel(
    id: "4",
    name: "Shoes",
    imgUrl:
        "https://images.unsplash.com/photo-1463100099107-aa0980c362e6?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170",
    productsCount: 150,
  ),
  CategoryItemModel(
    id: "5",
    name: "Elctronics",
    imgUrl:
        "https://images.unsplash.com/photo-1498049794561-7780e7231661?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170",
    productsCount: 150,
  ),
];
