// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:barcode_app/network/network_manager.dart' as _i483;
import 'package:barcode_app/resources/strings/asset_map.dart' as _i921;
import 'package:barcode_app/services/navigator_service.dart' as _i262;
import 'package:barcode_app/services/product_service.dart' as _i753;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i921.AssetMap>(() => _i921.AssetMap());
    gh.lazySingleton<_i483.NetworkManager>(() => _i483.NetworkManager());
    gh.lazySingleton<_i262.NavigatorService>(() => _i262.NavigatorService());
    gh.lazySingleton<_i753.ProductService>(
        () => _i753.ProductService(gh<_i483.NetworkManager>()));
    return this;
  }
}
