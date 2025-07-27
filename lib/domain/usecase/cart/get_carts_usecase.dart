// import '../../entity/cart_entity.dart';
// import '../../repository/cart_repository.dart';
// import '../usecase.dart';

// class GetCartsUseCase implements UseCase<List<CartEntity>, GetCartsParams> {
//   final CartRepository repository;

//   GetCartsUseCase(this.repository);

//   @override
//   Future<List<CartEntity>> call(GetCartsParams params) async {
//     return await repository.getCart(
//       params.userId,
//       startDate: params.startDate,
//       endDate: params.endDate,
//     );
//   }
// }

// class GetCartsParams {
//   final String userId;
//   final DateTime? startDate;
//   final DateTime? endDate;

//   GetCartsParams({
//     required this.userId,
//     this.startDate,
//     this.endDate,
//   });
// }