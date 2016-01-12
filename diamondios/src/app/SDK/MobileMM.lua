
local MobileMMSdk = class("MobileMMSdk")
local Store = import("framework.cc.sdk.Store")
local meta = MobileMMSdk
proPrice = {}

function meta:init(data)
     --初始化商店
    if table.nums(proPrice) <= 0 then
      Store.init(handler(self, self.storeCallback))
    end
    
    self.id = "3000084253089"
    -- self.id = "300008425309"
        --载入商品
    Store.loadProducts({
      self.id.."01",
      self.id.."02",
      self.id.."03",
      self.id.."04",
      self.id.."05",
      self.id.."06",
      self.id.."07"
    }, handler(self, self.loadCallback))
end

---商店的回调
function meta:storeCallback(transaction)
    --处理购买中的事件回调，如购买成功
    dump(transaction.transaction)
    if transaction.transaction.state == "purchased" then
      Store.finishTransaction(transaction.transaction)
      if self.success ~= nil then
          self.success()
      end
    elseif transaction.transaction.state == "cancelled" or transaction.transaction.state == "failed" then
      if self.fail ~= nil then
          self.fail()
      end
    end
end
 
---载入商品的毁掉
function meta:loadCallback(products)
    --返回商品列表
    proPrice = products
    dump(products)
end

function meta:init_callback(event)
    print("mminitEnd")
end


--平台支付
function meta:payment(orderId,successCallBack,failCallBack)
    Store.purchase(self.id ..orderId)
    dump(self.id ..orderId)
    self.success = successCallBack
    self.fail = failCallBack
end

function meta:payment_callback(event,successCallBack,failCallBack)

    local ret = string.split(event, ",")

    if #ret >= 4 then
        successCallBack()
    else
        if failCallBack ~= nil then 
            failCallBack()
        end
    end
    
end

return meta