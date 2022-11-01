import React from 'react'

// ./ говорит react, что файлы нужно искать в тойже директории, что и обрабатываемый файл (index.jsx)
import NoPayType from './NoPayType'
import CreditCardPayType from './CreditCardPayType'
import CheckPayType from './CheckPayType'
import PurchaseOrderPayType from './PurchaseOrderPayType'

// Нельзя использовать ключевые слова JavaScript для атрибутов
// поэтому используются className и htmlFor
// тоже самое касается события onChange вместо onchange
// фигурные скобки это аналог <%= ... %> в Руби (<select onChange={this.onPayTypeSelected}...)
class PayTypeSelector extends React.Component {
    constructor(props) {
        super(props);
        //
        this.onPayTypeSelected = this.onPayTypeSelected.bind(this);
        this.state = {selectedPayType: null};
    }

    render() {

        let PayTypeCustomComponent = NoPayType;
        if (this.state.selectedPayType == "Credit card") {
            PayTypeCustomComponent = CreditCardPayType;
        } else if (this.state.selectedPayType == "Check") {
            PayTypeCustomComponent = CheckPayType;
        } else if (this.state.selectedPayType == "Purchase order") {
            PayTypeCustomComponent = PurchaseOrderPayType;
        }

        return (
            <div>
                <div className="field">
                    <label htmlFor="order_pay_type">
                        {I18n.t("orders.form.pay_type")}
                    </label>
                    <select id="order_pay_type" onChange={this.onPayTypeSelected} name="order[pay_type]">
                        <option value="">{I18n.t("orders.form.pay_prompt_html")}</option>
                        <option value="Check">{I18n.t("orders.form.pay_types.check")}</option>
                        <option value="Credit card">{I18n.t("orders.form.pay_types.credit_card")}</option>
                        <option value="Purchase order">{I18n.t("orders.form.pay_types.purchase_order")}</option>
                    </select>
                </div>
                <PayTypeCustomComponent />
            </div>
        );
    }

    onPayTypeSelected(event) {
        // console.log(event.target.value);
        // Устанавливаем выбранное состояние компонента
        this.setState({selectedPayType: event.target.value});
    }
}

//В JavaScript необходимо явно указать, что экспортируется из файла.
export default PayTypeSelector