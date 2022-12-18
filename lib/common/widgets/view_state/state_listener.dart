import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../utils/loading.dart';

enum ViewState { IDLE, BUSY, EMPTY, SUCCESS, ERROR, NO_NET }
mixin ViewStateManager {
  final Rx<ViewState> _viewState = ViewState.IDLE.obs;

  get viewState => _viewState;

  setIdle({bool enableLoading = true}) {
    if (enableLoading) {
      dismissLoading();
    } else {
      this._viewState.value = ViewState.IDLE;
    }
  }

  setBusy({bool enableLoading = true, String? t}) {
    if (enableLoading) {
      showLoading(t: t);
    } else {
      this._viewState.value = ViewState.BUSY;
    }
  }

  setEmpty({bool enableLoading = true}) {
    if (enableLoading) {
      dismissLoading();
    } else {
      this._viewState.value = ViewState.EMPTY;
    }
  }

  setSuccess({bool enableLoading = true, String? t}) {
    if (enableLoading) {
      showSuccess(t: t);
    } else {
      this._viewState.value = ViewState.SUCCESS;
    }
  }

  setError({bool enableLoading = true, String? t}) {
    if (enableLoading) {
      showError(t: t);
    } else {
      this._viewState.value = ViewState.ERROR;
    }
  }

  setNoNet({bool enableLoading = true}) {
    if (enableLoading) {
      dismissLoading();
    }else{
      this._viewState.value = ViewState.NO_NET;
    }
  }

  setProgress({required double p, String? t}) {
    showProgress(p,status: t);
  }
}
