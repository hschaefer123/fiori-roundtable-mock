using SalesOrderService as service from '../../srv/SalesOrder-service';

// Criticality mapping for status:
// 'Open' → 5 (Informative)
// 'In Process' → 2 (Critical)
// 'Completed' → 3 (Positive)
// 'Error' → 1 (Negative)
annotate service.SalesOrders with @(

    UI.SelectionFields: [
        customerName,
        orderDate,
        status
    ],

    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : orderId,
            },
            {
                $Type : 'UI.DataField',
                Value : customerName,
            },
            {
                $Type : 'UI.DataField',
                Value : orderDate,
            },
            {
                $Type : 'UI.DataField',
                Value : netAmount,
            },
            {
                $Type : 'UI.DataField',
                Value : status,
            },
        ],
    },

    UI.DataPoint #netAmount: {
        Value: netAmount,
        Title: 'Net Amount',
    },

    UI.DataPoint #orderDate: {
        Value: orderDate,
        Title: 'Order Date',
    },

    UI.DataPoint #status: {
        Value: status,
        Title: 'Status',
        Criticality: (
            status = 'Error' ? 1 :      // Negative
            status = 'In Process' ? 2 : // Critical
            status = 'Completed' ? 3 :  // Positive
            5                           // Informative (default for 'Open')
        ),
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],

    UI.HeaderInfo: {
        TypeName      : 'SalesOrder',
        TypeNamePlural: 'SalesOrders',
        Title         : { $Type: 'UI.DataField', Value: orderId },
        Description   : { $Type: 'UI.DataField', Value: customerName }
    },

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : orderId,
        },
        {
            $Type : 'UI.DataField',
            Value : customerName,
        },
        {
            $Type : 'UI.DataField',
            Value : orderDate,
        },
        {
            $Type : 'UI.DataField',
            Value : netAmount,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#status',
        },
    ],
);

