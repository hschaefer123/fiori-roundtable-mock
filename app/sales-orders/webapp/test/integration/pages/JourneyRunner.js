sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"salesorders/test/integration/pages/SalesOrdersList",
	"salesorders/test/integration/pages/SalesOrdersObjectPage"
], function (JourneyRunner, SalesOrdersList, SalesOrdersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('salesorders') + '/test/flpSandbox.html#salesorders-tile',
        pages: {
			onTheSalesOrdersList: SalesOrdersList,
			onTheSalesOrdersObjectPage: SalesOrdersObjectPage
        },
        async: true
    });

    return runner;
});

