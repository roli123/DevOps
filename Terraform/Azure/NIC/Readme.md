**Note: Network Interface and Public IP in Azure**

* A **Network Interface Card (NIC)** depends on the **subnet** it is associated with.
* A **Public IP** depends on the **resource group** it is created in.
* After creating a Public IP, it must be **associated with the NIC**.
* This is done by referencing the Public IP in the NIC’s IP configuration:

```hcl
public_ip_address_id = azurerm_public_ip.publicip.id
```

This links the NIC to the allocated Public IP.


