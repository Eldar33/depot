
// Доступ к главной react библиотеке
import React            from 'react'
// Это дает использовать ReactDOM, у которого есть функция render(), необходимая для начальной загрузки нашего компонента React.
import ReactDOM         from 'react-dom'
// Подгружаем наш компонент (Webpack загрузит app/javascript/PayTypeSelector/index.jsx)
import PayTypeSelector  from 'PayTypeSelector'

// Использование turbolinks:load гарантирует, что React настраивается каждый раз при отображении страницы.
// Не использовать DOMContentLoaded, т.к. событие не отрабатыает при возврате на страницу кнопкой Назад
document.addEventListener('turbolinks:load', function() {
    var element = document.getElementById("pay-type-component");
    //функция render заменяет element на компонент PayTypeSelector
    ReactDOM.render(<PayTypeSelector />, element);
});