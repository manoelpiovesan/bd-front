abstract class AbstractModel {
  /// Returns a map representation of the model.
  Map<String, dynamic> toJson();

  AbstractModel();

  /// Creates an instance of the model from a map.
  AbstractModel.fromJson();

}
