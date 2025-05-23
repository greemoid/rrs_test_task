import 'package:fpdart/fpdart.dart';

import '../../core/failures/failure.dart';
import '../entities/gadget.dart';

abstract interface class GadgetRepository {
  Future<Either<Failure, List<Gadget>>> getGadgets();
}
