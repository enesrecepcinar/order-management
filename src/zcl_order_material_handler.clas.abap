class ZCL_ORDER_MATERIAL_HANDLER definition
  public
  final
  create public .

public section.

  class-methods GET_ORDER_INFO
    importing
      !IR_EBELN type ANY TABLE optional
      !IR_MATNR type ANY TABLE optional
      !IR_LIFNR type ANY TABLE optional
    exporting
      !ET_ORDER_DATA type ZRC_TT_ORDER_DATA .
  class-methods GET_MATERIAL_INFO
    importing
      !IV_MATNR type MATNR
    exporting
      !ET_MATERIAL_DATA type ZRC_TT_MATERIAL_DATA .
protected section.
private section.
ENDCLASS.



CLASS ZCL_ORDER_MATERIAL_HANDLER IMPLEMENTATION.


  METHOD get_material_info.

  SELECT *
  INTO CORRESPONDING FIELDS OF TABLE @et_material_data
  FROM mara
  WHERE matnr = @iv_matnr.

  ENDMETHOD.


  METHOD get_order_info.

    " Select data from EKPO and EKKO tables
    SELECT *
      INTO CORRESPONDING FIELDS OF TABLE @et_order_data
      FROM ekko AS a LEFT OUTER JOIN ekpo AS b ON b~ebeln = a~ebeln
      WHERE a~ebeln   in @ir_ebeln
      AND   a~lifnr   in @ir_lifnr
      AND   b~matnr   in @ir_matnr.


  ENDMETHOD.
ENDCLASS.
