// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String CampNameValueKey = 'campName';
const String LinkValueKey = 'link';
const String UsbValueKey = 'usb';
const String VideoDurationValueKey = 'videoDuration';

final Map<String, TextEditingController> _EditCampPageTextEditingControllers =
    {};

final Map<String, FocusNode> _EditCampPageFocusNodes = {};

final Map<String, String? Function(String?)?> _EditCampPageTextValidations = {
  CampNameValueKey: null,
  LinkValueKey: null,
  UsbValueKey: null,
  VideoDurationValueKey: null,
};

mixin $EditCampPage {
  TextEditingController get campNameController =>
      _getFormTextEditingController(CampNameValueKey);
  TextEditingController get linkController =>
      _getFormTextEditingController(LinkValueKey);
  TextEditingController get usbController =>
      _getFormTextEditingController(UsbValueKey);
  TextEditingController get videoDurationController =>
      _getFormTextEditingController(VideoDurationValueKey);

  FocusNode get campNameFocusNode => _getFormFocusNode(CampNameValueKey);
  FocusNode get linkFocusNode => _getFormFocusNode(LinkValueKey);
  FocusNode get usbFocusNode => _getFormFocusNode(UsbValueKey);
  FocusNode get videoDurationFocusNode =>
      _getFormFocusNode(VideoDurationValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_EditCampPageTextEditingControllers.containsKey(key)) {
      return _EditCampPageTextEditingControllers[key]!;
    }

    _EditCampPageTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _EditCampPageTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_EditCampPageFocusNodes.containsKey(key)) {
      return _EditCampPageFocusNodes[key]!;
    }
    _EditCampPageFocusNodes[key] = FocusNode();
    return _EditCampPageFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    campNameController.addListener(() => _updateFormData(model));
    linkController.addListener(() => _updateFormData(model));
    usbController.addListener(() => _updateFormData(model));
    videoDurationController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    campNameController.addListener(() => _updateFormData(model));
    linkController.addListener(() => _updateFormData(model));
    usbController.addListener(() => _updateFormData(model));
    videoDurationController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          CampNameValueKey: campNameController.text,
          LinkValueKey: linkController.text,
          UsbValueKey: usbController.text,
          VideoDurationValueKey: videoDurationController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _EditCampPageTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _EditCampPageFocusNodes.values) {
      focusNode.dispose();
    }

    _EditCampPageTextEditingControllers.clear();
    _EditCampPageFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get campNameValue => this.formValueMap[CampNameValueKey] as String?;
  String? get linkValue => this.formValueMap[LinkValueKey] as String?;
  String? get usbValue => this.formValueMap[UsbValueKey] as String?;
  String? get videoDurationValue =>
      this.formValueMap[VideoDurationValueKey] as String?;

  set campNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({CampNameValueKey: value}),
    );

    if (_EditCampPageTextEditingControllers.containsKey(CampNameValueKey)) {
      _EditCampPageTextEditingControllers[CampNameValueKey]?.text = value ?? '';
    }
  }

  set linkValue(String? value) {
    this.setData(
      this.formValueMap..addAll({LinkValueKey: value}),
    );

    if (_EditCampPageTextEditingControllers.containsKey(LinkValueKey)) {
      _EditCampPageTextEditingControllers[LinkValueKey]?.text = value ?? '';
    }
  }

  set usbValue(String? value) {
    this.setData(
      this.formValueMap..addAll({UsbValueKey: value}),
    );

    if (_EditCampPageTextEditingControllers.containsKey(UsbValueKey)) {
      _EditCampPageTextEditingControllers[UsbValueKey]?.text = value ?? '';
    }
  }

  set videoDurationValue(String? value) {
    this.setData(
      this.formValueMap..addAll({VideoDurationValueKey: value}),
    );

    if (_EditCampPageTextEditingControllers.containsKey(
        VideoDurationValueKey)) {
      _EditCampPageTextEditingControllers[VideoDurationValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasCampName =>
      this.formValueMap.containsKey(CampNameValueKey) &&
      (campNameValue?.isNotEmpty ?? false);
  bool get hasLink =>
      this.formValueMap.containsKey(LinkValueKey) &&
      (linkValue?.isNotEmpty ?? false);
  bool get hasUsb =>
      this.formValueMap.containsKey(UsbValueKey) &&
      (usbValue?.isNotEmpty ?? false);
  bool get hasVideoDuration =>
      this.formValueMap.containsKey(VideoDurationValueKey) &&
      (videoDurationValue?.isNotEmpty ?? false);

  bool get hasCampNameValidationMessage =>
      this.fieldsValidationMessages[CampNameValueKey]?.isNotEmpty ?? false;
  bool get hasLinkValidationMessage =>
      this.fieldsValidationMessages[LinkValueKey]?.isNotEmpty ?? false;
  bool get hasUsbValidationMessage =>
      this.fieldsValidationMessages[UsbValueKey]?.isNotEmpty ?? false;
  bool get hasVideoDurationValidationMessage =>
      this.fieldsValidationMessages[VideoDurationValueKey]?.isNotEmpty ?? false;

  String? get campNameValidationMessage =>
      this.fieldsValidationMessages[CampNameValueKey];
  String? get linkValidationMessage =>
      this.fieldsValidationMessages[LinkValueKey];
  String? get usbValidationMessage =>
      this.fieldsValidationMessages[UsbValueKey];
  String? get videoDurationValidationMessage =>
      this.fieldsValidationMessages[VideoDurationValueKey];
}

extension Methods on FormStateHelper {
  setCampNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CampNameValueKey] = validationMessage;
  setLinkValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[LinkValueKey] = validationMessage;
  setUsbValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[UsbValueKey] = validationMessage;
  setVideoDurationValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[VideoDurationValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    campNameValue = '';
    linkValue = '';
    usbValue = '';
    videoDurationValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      CampNameValueKey: getValidationMessage(CampNameValueKey),
      LinkValueKey: getValidationMessage(LinkValueKey),
      UsbValueKey: getValidationMessage(UsbValueKey),
      VideoDurationValueKey: getValidationMessage(VideoDurationValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _EditCampPageTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _EditCampPageTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      CampNameValueKey: getValidationMessage(CampNameValueKey),
      LinkValueKey: getValidationMessage(LinkValueKey),
      UsbValueKey: getValidationMessage(UsbValueKey),
      VideoDurationValueKey: getValidationMessage(VideoDurationValueKey),
    });
