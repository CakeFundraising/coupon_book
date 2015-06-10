var BookCategoryDiscounts = React.createClass({

    mixins: [SortableMixin],

    sortableOptions: {
        group: "organize",
        animation: 200
    },

    getInitialState: function () {
        return {
            items: ['items', 'another item']
        };
    },

    render: function() {
        return (
            <ul className={this.props.className} id={this.props.id}>
                {this.renderCategoryList()}
            </ul>
        );
    },

    renderCategoryList: function () {
        return (
            this.state.items.map (function (item, index) {
                return (
                    <li className="coupon-list" key={index}>
                        {item}
                    </li>
                );
            })
        );
    }
});
