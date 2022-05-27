-- subscription switch
-- USE IN POWERBI - without function of diff of dates 
with lic_poi as (
	-- license point of interest
	-- perpetual licenses at start of FY22 with expiration during the FY22 
	/*-- option 1
		select
			Lic_Hist.SK_License_Master -- main ID of license
			, Lic_Hist.NAME_ProjectName 
			, Lic_Hist.SK_Account_Master 
			-- partner
			-- teritory
			-- owner = account manager
			, Lic_Hist.NAME_LicenseType -- perpetual/subscr
			, Lic_Hist.SK_Date_Purchase 
			, Lic_Hist.AMT_MaintenancePriceUSD -- expect Maintenance price on license
			, Lic_Hist.SK_Date_ExpiresOn 
			, Lic_Hist.URL_Source 
		from
			DW_BUSINESS_PBI.dbo.PBI_D_License_Hist Lic_Hist
		where 
			'2021-07-01' between DATE_ValidFrom and DATE_ValidTo -- inputs from start of the fiskal
			and SK_Date_ExpiresOn between '2021-07-01' and '2022-06-30' -- Expiration of licenses during FY22
			and NAME_LicenseType = 'Perpetual' -- only perpetual licenses 
			and ID_Source in ('34e3cafe-a2bb-ea11-a812-000d3ab615a7','9df86873-a2bb-ea11-a812-000d3ab615a7','61e5887a-a2c2-e511-810d-3863bb355d00','675fb6fb-38f7-e511-811a-3863bb35fed0','946afb38-a7c2-e511-810d-3863bb355d00','957beecd-6e43-ea11-a812-000d3ab615df','7dfb1204-d20a-e911-a969-000d3ab49476','d659ca72-a0c2-e511-810d-3863bb355d00','80455284-a5c2-e511-810d-3863bb355d00','d1502b3f-a7c2-e511-810d-3863bb355d00','464939fa-e57d-e811-8140-e0071b6641c1','6ee5887a-a2c2-e511-810d-3863bb355d00','4cd57a88-a07e-e811-8140-e0071b6641c1','462f57a8-d57e-e811-8140-e0071b6641c1','60932f1c-c95f-e711-8105-e0071b6641c1','02c663a2-d17e-e811-8140-e0071b6641c1','da3409bd-929d-e911-a978-000d3ab492e1','eb502b3f-a7c2-e511-810d-3863bb355d00','e4e0b04b-cd5f-e711-8105-e0071b6641c1','53b9ae69-529e-e911-a978-000d3ab492e1','72b24000-f241-e611-80e4-5065f38bb581','edb09d9b-9ec2-e511-810d-3863bb355d00','f24f5af8-9fc2-e511-810d-3863bb355d00','944b8680-a2c2-e511-810d-3863bb355d00','a84b8680-a2c2-e511-810d-3863bb355d00','8e870c88-9bc2-e511-810d-3863bb355d00','7e7bf724-9a70-e911-a973-000d3ab49476','c2d032fd-9cc2-e511-810d-3863bb355d00','f53bd552-9ec2-e511-810d-3863bb355d00','c64b8680-a2c2-e511-810d-3863bb355d00','8c61258f-ee44-e611-80e4-5065f38bb581','0b512b3f-a7c2-e511-810d-3863bb355d00','3dd4c2bb-9bc0-ea11-a812-000d3ab615a7','bf1cffd5-9bc0-ea11-a812-000d3ab615a7','5c701b7e-9bc0-ea11-a812-000d3ab615a7','7f546156-9ac0-ea11-a812-000d3ab615a7','909aa190-9bc0-ea11-a812-000d3ab615a7','ac605a99-9ac0-ea11-a812-000d3ab615a7','cd699da2-9bc0-ea11-a812-000d3ab615a7','f2005f65-9bc0-ea11-a812-000d3ab615a7','8a40459a-6f83-e811-8142-e0071b6641c1','93b1cd78-a0c2-e511-810d-3863bb355d00','87b1cd78-a0c2-e511-810d-3863bb355d00','ae47b090-28a2-e911-a971-000d3ab496ce','a981ee7e-a0c2-e511-810d-3863bb355d00','048f8c52-0ea3-e911-a971-000d3ab496ce','3149c9c5-96c2-e511-810d-3863bb355d00','9ecd9886-a2c2-e511-810d-3863bb355d00','a4cd9886-a2c2-e511-810d-3863bb355d00','80aa5545-a7c2-e511-810d-3863bb355d00','adcd9886-a2c2-e511-810d-3863bb355d00','5bf4e684-a0c2-e511-810d-3863bb355d00','0d709998-99c2-e511-810d-3863bb355d00','22ed0c24-db66-e711-8108-e0071b6641c1','6ff4e684-a0c2-e511-810d-3863bb355d00','2734ec3e-ec48-e611-80e4-5065f38bb581','a1aa5545-a7c2-e511-810d-3863bb355d00','179da81d-e948-e611-80e4-5065f38bb581','5c05614b-a7c2-e511-810d-3863bb355d00','b0566b7b-cc49-e611-80e5-5065f38bb581','787adeae-a5c2-e511-810d-3863bb355d00','7ef4e684-a0c2-e511-810d-3863bb355d00','9e7adeae-a5c2-e511-810d-3863bb355d00','7205614b-a7c2-e511-810d-3863bb355d00','dcf6c501-d488-e811-8144-e0071b6641c1','8946faba-a5c2-e511-810d-3863bb355d00','1d8b9d8c-a2c2-e511-810d-3863bb355d00','e78c94a0-9bc2-e511-810d-3863bb355d00','b69735d1-9bc2-e511-810d-3863bb355d00','7c05614b-a7c2-e511-810d-3863bb355d00','1f8b1465-d389-e811-8144-e0071b6641c1','f4ce4808-e04c-e611-80e5-5065f38bb581','eaf50f84-b78a-e811-8144-e0071b6641c1','8e98bb2f-04ed-e511-8103-3863bb348bb0','31db626c-bf8a-e811-8144-e0071b6641c1','b23da492-a2c2-e511-810d-3863bb355d00','1a0dfa18-9d4d-e611-80e5-5065f38bb581','eb732c1c-9ec2-e511-810d-3863bb355d00','a9a752f5-5b6c-e711-8108-e0071b6641c1','4af4583c-048c-e811-8146-e0071b6641c1','94944cdd-9bc2-e511-810d-3863bb355d00','6756e44e-058c-e811-8146-e0071b6641c1','e9673f41-0b8c-e811-8146-e0071b6641c1','79ba4e91-a0c2-e511-810d-3863bb355d00','a42915b1-f137-ec11-8c64-000d3ab07f60','8d466fee-ef2d-ec11-b6e6-000d3adf1958','3c11f64c-c9fa-eb11-94ef-0022489c98c9','61fcc88e-9cc2-e511-810d-3863bb355d00')
	*/
	-- option 2
	-- selected from freze report at July 21 2021 -> Oct 21 2022
		select
			flmrfm.SK_License_Master 
			, pdlc.NAME_ProjectName_Cur
			, da.[Account Name]
			, da2.[Account Name] as Partner_name
			, da.[Account Territory]
                        , da.[Account Region]
			, da.[Account Manager] as owner
			, flmrfm.NAME_LicenseType_Cur 
			, flmrfm.SK_Date_Purchase_Cur
			, flmrfm.AMT_ExpectedRevenue
			, flmrfm.SK_Date_ExpiresOn_Cur 
			, flmrfm.CRM_Url_License 
		from
			DW_REPORTS.marketing_sales.F_Licence_MaintenanceRenewal_Forecast_Materialized_2021 flmrfm
		left join
			DW_BUSINESS_PBI.dbo.PBI_D_License_Current pdlc 
				on flmrfm.SK_License_Master = pdlc.SK_License_Master 
		left JOIN 
			DW_REPORTS.marketing_sales.D_Account da 
				on da.SK_Account_Master = pdlc.SK_Account_Master
		left JOIN 
			DW_REPORTS.marketing_sales.D_Account da2
				on da.SK_Account_Master_Partner = da2.SK_Account_Master
		where flmrfm.NAME_LicenseType_Cur = 'Perpetual'
		union
		select
			Lic_Hist.SK_License_Master -- main ID of license
			, pdlc_2.NAME_ProjectName_Cur 
			, da_2.[Account Name]
			, da2_2.[Account Name] as Partner_name
			, da_2.[Account Territory]
                        , da_2.[Account Region]
			, da_2.[Account Manager] as owner
			, Lic_Hist.NAME_LicenseType -- perpetual/subscr
			, Lic_Hist.SK_Date_Purchase 
			, Lic_Hist.AMT_MaintenancePriceUSD -- expect Maintenance price on license
			, Lic_Hist.SK_Date_ExpiresOn 
			, Lic_Hist.URL_Source 
		from
			DW_BUSINESS_PBI.dbo.PBI_D_License_Hist Lic_Hist
		left join
			DW_BUSINESS_PBI.dbo.PBI_D_License_Current pdlc_2 
				on Lic_Hist.SK_License_Master = pdlc_2.SK_License_Master 
		left JOIN 
			DW_REPORTS.marketing_sales.D_Account da_2 
				on da_2.SK_Account_Master = pdlc_2.SK_Account_Master
		left JOIN 
			DW_REPORTS.marketing_sales.D_Account da2_2
				on da_2.SK_Account_Master_Partner = da2_2.SK_Account_Master
		where 
			'2021-06-30' between Lic_Hist.DATE_ValidFrom and Lic_Hist.DATE_ValidTo -- inputs from start of the fiskal
			and Lic_Hist.ID_Source in ('8946faba-a5c2-e511-810d-3863bb355d00','34e3cafe-a2bb-ea11-a812-000d3ab615a7','9df86873-a2bb-ea11-a812-000d3ab615a7','61e5887a-a2c2-e511-810d-3863bb355d00','675fb6fb-38f7-e511-811a-3863bb35fed0','946afb38-a7c2-e511-810d-3863bb355d00','957beecd-6e43-ea11-a812-000d3ab615df','7dfb1204-d20a-e911-a969-000d3ab49476','d659ca72-a0c2-e511-810d-3863bb355d00','80455284-a5c2-e511-810d-3863bb355d00','d1502b3f-a7c2-e511-810d-3863bb355d00','464939fa-e57d-e811-8140-e0071b6641c1','6ee5887a-a2c2-e511-810d-3863bb355d00','4cd57a88-a07e-e811-8140-e0071b6641c1','462f57a8-d57e-e811-8140-e0071b6641c1','60932f1c-c95f-e711-8105-e0071b6641c1','02c663a2-d17e-e811-8140-e0071b6641c1','da3409bd-929d-e911-a978-000d3ab492e1','eb502b3f-a7c2-e511-810d-3863bb355d00','e4e0b04b-cd5f-e711-8105-e0071b6641c1','53b9ae69-529e-e911-a978-000d3ab492e1','72b24000-f241-e611-80e4-5065f38bb581','edb09d9b-9ec2-e511-810d-3863bb355d00','f24f5af8-9fc2-e511-810d-3863bb355d00','944b8680-a2c2-e511-810d-3863bb355d00','a84b8680-a2c2-e511-810d-3863bb355d00','8e870c88-9bc2-e511-810d-3863bb355d00','7e7bf724-9a70-e911-a973-000d3ab49476','c2d032fd-9cc2-e511-810d-3863bb355d00','f53bd552-9ec2-e511-810d-3863bb355d00','c64b8680-a2c2-e511-810d-3863bb355d00','8c61258f-ee44-e611-80e4-5065f38bb581','0b512b3f-a7c2-e511-810d-3863bb355d00','3dd4c2bb-9bc0-ea11-a812-000d3ab615a7','bf1cffd5-9bc0-ea11-a812-000d3ab615a7','5c701b7e-9bc0-ea11-a812-000d3ab615a7','7f546156-9ac0-ea11-a812-000d3ab615a7','909aa190-9bc0-ea11-a812-000d3ab615a7','ac605a99-9ac0-ea11-a812-000d3ab615a7','cd699da2-9bc0-ea11-a812-000d3ab615a7','f2005f65-9bc0-ea11-a812-000d3ab615a7','8a40459a-6f83-e811-8142-e0071b6641c1','93b1cd78-a0c2-e511-810d-3863bb355d00','87b1cd78-a0c2-e511-810d-3863bb355d00','ae47b090-28a2-e911-a971-000d3ab496ce','a981ee7e-a0c2-e511-810d-3863bb355d00','048f8c52-0ea3-e911-a971-000d3ab496ce','3149c9c5-96c2-e511-810d-3863bb355d00','9ecd9886-a2c2-e511-810d-3863bb355d00','a4cd9886-a2c2-e511-810d-3863bb355d00','80aa5545-a7c2-e511-810d-3863bb355d00','adcd9886-a2c2-e511-810d-3863bb355d00','5bf4e684-a0c2-e511-810d-3863bb355d00','0d709998-99c2-e511-810d-3863bb355d00','22ed0c24-db66-e711-8108-e0071b6641c1','6ff4e684-a0c2-e511-810d-3863bb355d00','2734ec3e-ec48-e611-80e4-5065f38bb581','a1aa5545-a7c2-e511-810d-3863bb355d00','179da81d-e948-e611-80e4-5065f38bb581','5c05614b-a7c2-e511-810d-3863bb355d00','b0566b7b-cc49-e611-80e5-5065f38bb581','787adeae-a5c2-e511-810d-3863bb355d00','7ef4e684-a0c2-e511-810d-3863bb355d00','9e7adeae-a5c2-e511-810d-3863bb355d00','7205614b-a7c2-e511-810d-3863bb355d00','dcf6c501-d488-e811-8144-e0071b6641c1','1d8b9d8c-a2c2-e511-810d-3863bb355d00','e78c94a0-9bc2-e511-810d-3863bb355d00','b69735d1-9bc2-e511-810d-3863bb355d00','7c05614b-a7c2-e511-810d-3863bb355d00','1f8b1465-d389-e811-8144-e0071b6641c1','f4ce4808-e04c-e611-80e5-5065f38bb581','eaf50f84-b78a-e811-8144-e0071b6641c1','8e98bb2f-04ed-e511-8103-3863bb348bb0','31db626c-bf8a-e811-8144-e0071b6641c1','b23da492-a2c2-e511-810d-3863bb355d00','1a0dfa18-9d4d-e611-80e5-5065f38bb581','eb732c1c-9ec2-e511-810d-3863bb355d00','a9a752f5-5b6c-e711-8108-e0071b6641c1','4af4583c-048c-e811-8146-e0071b6641c1','94944cdd-9bc2-e511-810d-3863bb355d00','6756e44e-058c-e811-8146-e0071b6641c1','e9673f41-0b8c-e811-8146-e0071b6641c1','79ba4e91-a0c2-e511-810d-3863bb355d00','a42915b1-f137-ec11-8c64-000d3ab07f60','8d466fee-ef2d-ec11-b6e6-000d3adf1958','3c11f64c-c9fa-eb11-94ef-0022489c98c9')
	),
-- ORDERS CALCULATION
-- subscription switch orders for perpetual licences fulfilled during FY22 in status invoiced and further (perpatual -> subscript)
	-- orders with subscription switch -> group on order -> total MMR and Extra money -> group on license (1 thing splited to 2 orders because of customer)
sw_ord_grouped as 
	( -- orders with subscription switch grouped on order
		select
			ord.[Order Number]
			, ord.[Order Status] -- compl/invoiced/paid
			, ord.[SK_License_Master]
			, ord.DTIME_Order_Paid -- date payment
			, ord.URL_Source -- order link
			, ord.[DATE Fulfilled] 
			, MIN_DATE_Start_On = -- on order
				min(ord.[DATE Start On]) 
			, MAX_DATE_Expire_On = -- on order
				max(ord.[DATE Expire On])  
			, MRR_subscription_license =  -- MRR license subscription
				sum(case when ord.[OrderItem License Type] = 'Subscription' 
						then ord.[MRR (First Year)]
						else 0 
					end) 
			, Multiyear_extra_money = -- extra money from license
				sum(case when ord.[OrderItem License Type] = 'Subscription'
						then [Revenue USD Multiyear]
						else 0 
					end) 
		  	, Service_extra_money = -- extra services
		  		sum(case when ord.[Services Type] <> 'N/A' 
		  				then ord.[Revenue USD Averaged] 
		  				else 0 
	  				end)
			, Total_revenue = 
				sum(case when ord.[OrderItem License Type] = 'Subscription'
						then ord.[Revenue USD]
						else 0
					end)
		from
			[DW_REPORTS].[marketing_sales].[F_OrderItem] ord
		left join
			[DW_BUSINESS_PBI].dbo.PBI_D_Product_Current pr
				on ord.SK_Product_Master = pr.SK_Product_Master
		where
			ord.[SK_License_Master] in 
				( -- licenses what we are interested in:
					select
						lic_poi.SK_License_Master
					FROM 
						lic_poi
				)
			and (
				(ord.[Order Status] IN ('Completed','Paid')
					and ord.[DATE Fulfilled] between '2021-07-01' and '2022-06-30')
				or (ord.[Order Status] IN ('Invoiced')
					and ord.[DTIME_Inserted_Cur] between '2021-07-01' and '2022-06-30')
				)
			and pr.FLAG_IsSubscription_Cur = 'Y'
			and ord.[Moved From] = 'Perpetual'
			--and ord.[Order Number] ='ORD-51431-M5K2C7' -- multiyear service subscr. training - no ARR Multiyear
			--and SK_License_Master IN (44574) -- license with 2 orders for same timeframe
		group by
			ord.[Order Number]
			, ord.[Order Status]
			, ord.[SK_License_Master]
			, ord.DTIME_Order_Paid
			, ord.URL_Source
			, ord.[DATE Fulfilled]
	),
sw_license_total as 
	(
	-- get 1 order with total revenue for license when more orders on license at same time
		select 
			sw_ord_grouped.[SK_License_Master]
			, [Order Number g] =
				min(sw_ord_grouped.[Order Number])
			, MRR_subscription_license_g =
				sum(sw_ord_grouped.MRR_subscription_license)
			, Multiyear_extra_money_g = 
				sum(sw_ord_grouped.Multiyear_extra_money)
			, Service_extra_money_g = 
				sum(sw_ord_grouped.Service_extra_money)
			, Total_revenue_g =
				sum(sw_ord_grouped.Total_revenue)
		from 
			sw_ord_grouped
		group by 
			sw_ord_grouped.[SK_License_Master]
	),
subscription_data as
	(
		select -- 1 order with total revenue for 1 timeframe (potentially more orders on licence followed) 
			order_type = 'subscription'
			, slt.SK_License_Master
			, slt.[Order Number g]
			, slt.Total_revenue_g
			, slt.MRR_subscription_license_g
			, slt.Multiyear_extra_money_g
			, slt.Service_extra_money_g
			, sog.[Order Status]
			, sog.DTIME_Order_Paid
			, sog.URL_Source
			, sog.MIN_DATE_Start_On
			, sog.MAX_DATE_Expire_On
			, [Contract lenght] = 
			CAST((DATEDIFF(month, sog.MIN_DATE_Start_On, sog.MAX_DATE_Expire_On) + CASE WHEN DATEPART(DAY,sog.MIN_DATE_Start_On) > DATEPART(DAY, sog.MAX_DATE_Expire_On) THEN -1 ELSE 0 END) 
			+ DATEDIFF(day, CAST(DATEADD(month, (DATEDIFF(month, sog.MIN_DATE_Start_On, sog.MAX_DATE_Expire_On) + CASE WHEN DATEPART(DAY,sog.MIN_DATE_Start_On) > DATEPART(DAY, sog.MAX_DATE_Expire_On) THEN -1 ELSE 0 END), 
			sog.MIN_DATE_Start_On) as date), sog.MAX_DATE_Expire_On) * 1.0 / DATEDIFF(DAY,EOMONTH(DATEADD(month,-1,CAST(DATEADD(month, (DATEDIFF(month, sog.MIN_DATE_Start_On, sog.MAX_DATE_Expire_On) 
			+ CASE WHEN DATEPART(DAY,sog.MIN_DATE_Start_On) > DATEPART(DAY, sog.MAX_DATE_Expire_On) THEN -1 ELSE 0 END), sog.MIN_DATE_Start_On) as date))), 
			EOMONTH(CAST(DATEADD(month, (DATEDIFF(month, sog.MIN_DATE_Start_On, sog.MAX_DATE_Expire_On) + CASE WHEN DATEPART(DAY,sog.MIN_DATE_Start_On) > DATEPART(DAY, sog.MAX_DATE_Expire_On) THEN -1 ELSE 0 END), sog.MIN_DATE_Start_On) as date)))  as decimal(10,2))
		from 
			sw_license_total slt
		left join 
			sw_ord_grouped sog
				on slt.[Order Number g] = sog.[Order Number]
	),
-- renewal orders for perpetual licences fulfilled during FY22 in status invoiced and further (perpatual stay perpetual)
	-- sum revenue on order and setup start and expire of maintanance product on order
	-- sum orders for license with start-expire in the focus FY22
perp_ord_grouped as 
	(
		select -- orders with grouped on order
			ord.[Order Number]
			, ord.[Order Status]
			, ord.[SK_License_Master]
			, ord.[DTIME_Order_Paid] 
			, ord.[URL_Source]
			, Total_revenue =
				sum(ord.[Revenue USD])
			, MIN_DATE_Start_On =
				cast(min(case when ord.[DATE Start On] = '1800-01-01' then GETDATE() else ord.[DATE Start On] end) as date)
			, MAX_DATE_Expire_On =
				max(ord.[DATE Expire On])
	 	from
	 		[DW_REPORTS].[marketing_sales].[F_OrderItem] ord
		left join
			[DW_BUSINESS_PBI].[dbo].[PBI_D_Product_Current] pr
				on ord.[SK_Product_Master] = pr.[SK_Product_Master]
		where 
			ord.[SK_License_Master] in 
				( -- licenses what we are interested in:
					select
						lic_poi.SK_License_Master
					FROM 
						lic_poi
				)
			and (
				(ord.[Order Status] IN ('Completed','Paid')
					and ord.[DATE Fulfilled] between '2021-07-01' and '2022-06-30')
				or (ord.[Order Status] IN ('Invoiced')
					and ord.[DTIME_Inserted_Cur] between '2021-07-01' and '2022-06-30')
				)
			--and ord.[DATE Fulfilled]  between '2021-07-01' and '2022-06-30'
			and ord.[Moved From] = 'N/A'
			and ord.[OrderItem License Type] = 'Perpetual'
		group by  
			ord.[Order Number]
			, ord.[Order Status]
			, ord.[SK_License_Master]
			, ord.[DTIME_Order_Paid] 
			, ord.[URL_Source]
	),
perp_license_total as 
	(
	-- get 1 order with total revenue for license when more orders on license at same time
		select 
			perp_ord_grouped.[SK_License_Master]
			, [Order Number g] =
				min(perp_ord_grouped.[Order Number])
			, total_revenue_license_g =
				sum(perp_ord_grouped.Total_revenue)
			, MIN_DATE_Start_On_g =
				min(perp_ord_grouped.MIN_DATE_Start_On)
			, MAX_DATE_Expire_On_g =
				max(perp_ord_grouped.MAX_DATE_Expire_On)
			, [Contract lenght] = 
				CAST((DATEDIFF(month, min(perp_ord_grouped.MIN_DATE_Start_On), max(perp_ord_grouped.MAX_DATE_Expire_On)) + CASE WHEN DATEPART(DAY,min(perp_ord_grouped.MIN_DATE_Start_On)) > DATEPART(DAY, max(perp_ord_grouped.MAX_DATE_Expire_On)) THEN -1 ELSE 0 END) 
			+ DATEDIFF(day, CAST(DATEADD(month, (DATEDIFF(month, min(perp_ord_grouped.MIN_DATE_Start_On), max(perp_ord_grouped.MAX_DATE_Expire_On)) + CASE WHEN DATEPART(DAY,min(perp_ord_grouped.MIN_DATE_Start_On)) > DATEPART(DAY, max(perp_ord_grouped.MAX_DATE_Expire_On)) THEN -1 ELSE 0 END), 
			min(perp_ord_grouped.MIN_DATE_Start_On)) as date), max(perp_ord_grouped.MAX_DATE_Expire_On)) * 1.0 / DATEDIFF(DAY,EOMONTH(DATEADD(month,-1,CAST(DATEADD(month, (DATEDIFF(month, min(perp_ord_grouped.MIN_DATE_Start_On), max(perp_ord_grouped.MAX_DATE_Expire_On)) 
			+ CASE WHEN DATEPART(DAY,min(perp_ord_grouped.MIN_DATE_Start_On)) > DATEPART(DAY, max(perp_ord_grouped.MAX_DATE_Expire_On)) THEN -1 ELSE 0 END), min(perp_ord_grouped.MIN_DATE_Start_On)) as date))), 
			EOMONTH(CAST(DATEADD(month, (DATEDIFF(month, min(perp_ord_grouped.MIN_DATE_Start_On), max(perp_ord_grouped.MAX_DATE_Expire_On)) + CASE WHEN DATEPART(DAY,min(perp_ord_grouped.MIN_DATE_Start_On)) > DATEPART(DAY, max(perp_ord_grouped.MAX_DATE_Expire_On)) THEN -1 ELSE 0 END), min(perp_ord_grouped.MIN_DATE_Start_On)) as date)))  as decimal(10,2))
		from 
			perp_ord_grouped
		group by 
			perp_ord_grouped.[SK_License_Master]
	),
perpetual_data as
	(
		select -- 1 order with total revenue for 1 timeframe (potentially more orders on licence followed) 
			order_type = 'perpetual'	
			, plt.SK_License_Master
			, plt.[Order Number g]
			, plt.total_revenue_license_g -- total revenue paid during FY22
			, MRR_perpetual_license_g = -- for perpatual = total revenue / years of maintenance
				(plt.total_revenue_license_g / [Contract lenght]) -- difference between Start - Expire by CRM calculation
			, Multiyear_extra_money_g = -- calculated MY extra money according to contract lenght -> when more than 12 months = total revenue - (MRR_perp_license_g*12)
				case when
					[Contract lenght] > 12
				then
					total_revenue_license_g - (total_revenue_license_g / [Contract lenght] * 12)
				else
					0
				end
			, Service_extra_money_g = 0
			, pog.[Order Status]
			, pog.DTIME_Order_Paid
			, pog.URL_Source
			, plt.MIN_DATE_Start_On_g
			, plt.MAX_DATE_Expire_On_g
			, plt.[Contract lenght]
		from 
			perp_license_total plt
		left join 
			perp_ord_grouped pog
				on plt.[Order Number g] = pog.[Order Number]
	),
final_ord as 
	(
		select t.*
		, ROW_NUMBER() OVER (PARTITION BY t.[SK_License_Master] ORDER BY t.[DTIME_Order_Paid] DESC) AS rn
		from 
			(
			select
				perpetual_data.*
			from
				perpetual_data
			union
			select
				subscription_data.*
			from
				subscription_data
			)t
	),
final_opp as
	(
	-- last opportunity on licenses with renewal/subscr. switch
		select 
			max_opp.[SK_License_Master]
			, max_opp.[Opportunity Name]
			, max_opp.[Opportunity Type]
			, max_opp.[Opportunity State]
			, max_opp.URL_Source
			, max_opp.[DATE Inserted]
		from 
			(
				select
					ROW_NUMBER() OVER (PARTITION BY opp.[SK_License_Master] ORDER BY opp.[DTIME Inserted] DESC) AS rn
					, opp.*
				from
					[DW_REPORTS].[marketing_sales].[F_Opportunity] opp
				inner JOIN lic_poi -- just licenses what are in the first report
					on opp.[SK_License_Master] = lic_poi.[SK_License_Master]
					and opp.[DTIME Inserted] between DATEADD(month, -7, lic_poi.SK_Date_ExpiresOn_Cur) 
						and GETDATE()
				where
					opp.[Opportunity Type] in ('Renewal','Subscription switch') -- only opportunity renewal (maintanance prolongation) and subscr switch
					and opp.[Opportunity Pipeline] <> 'Canceled' -- opp canceled are out of this discovery (canceled = duplicate, other type of opp open etc.)
			) max_opp
		where 
			max_opp.rn = 1
	)
-- actual discounted maintenance for future taken from diff calculation
,[Date] AS (
   SELECT CAST(GETDATE() as date) AS [Date]
  )
,[License] AS (
  SELECT
       [Date].[Date]
      ,[Lic].[SK_License_Master]
      ,[Lic].[URL_Source]                                                                 AS [CRM_Url_License]
      ,[Lic].[ID_Source]                                                                  AS [ID_Source_License]
      ,[Acc].[ID_Source]                                                                  AS [ID_Source_Account]
      ,[AccPartner].[ID_Source]                                                           AS [ID_Source_AccountPartner]
      ,[AccMan].[ID_Source]                                                               AS [ID_Source_AccountManager]
      ,[Acc].[SK_User_Master_AccountManager]
      ,[Acc].[SK_Account_Master]
      ,[Acc].[SK_Geography_Master]
      ,[Acc].[SK_Account_Master_Parent]
      ,[Acc].[SK_Account_Master_Partner]
      ,[Lic].[SK_Product_Master]
      ,[Lic].[SK_Contact_Master]
      ,[Lic].[SK_Date_ExpiresOn_Cur]
      ,[Lic].[SK_Date_BasePricing_Cur]
      ,[Lic].[SK_Date_Purchase_Cur]
      ,[Lic].[SK_Date_LastUpgrade_Cur]
      ,[Lic].[AMT_MaintenancePriceUSD_Cur]
      ,prod.NAME_Product_Cur
      ,[Lic].[NAME_LicenseType_Cur] 
  FROM [DW_BUSINESS_PBI].[dbo].[PBI_D_License_Current] [Lic] 
  	inner join lic_poi
  		on lic_poi.SK_License_Master = Lic.SK_License_Master
      JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_Account_Current] AS [Acc] 
          ON ([Lic].[SK_Account_Master] = [Acc].[SK_Account_Master] 
          AND [Acc].[FLAG_IsTestingAccount_Cur] = 'N')
      LEFT JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_Account_Current] AS [AccPartner] 
          ON [Acc].[SK_Account_Master_Partner] = [AccPartner].[SK_Account_Master]
      JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_User_Current] AS [AccMan] 
          ON ([AccMan].[SK_User_Master] = [Acc].[SK_User_Master_AccountManager])
           JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_Product_Current] [prod] 
              ON [prod].[SK_Product_Master] = [lic].[SK_Product_Master] 
      CROSS JOIN [Date]
  WHERE 1=1
      AND [Lic].[NAME_LicenseType_Cur] IN ('Perpetual', 'SubscriptionLicense')
      AND [Lic].[NAME_StateCode_Cur] = 'Active'
  )
, [OrderItems] AS (
      SELECT
          [lic].[ID_Source]
          ,MAX([orditem].[DTIME_OrderDate_Cur]) AS [MaxDate]
      FROM [DW_BUSINESS_PBI].[dbo].[PBI_F_OrderItem_Current] [orditem] 
           JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_License_Current] [lic] 
              ON [orditem].[SK_License_Master] = [lic].[SK_License_Master] 
           JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_Product_Current] [prod] 
              ON [prod].[SK_Product_Master] = [orditem].[SK_Product_Master] 
              AND ([prod].[NAME_ProductType_Cur] = 'Xperience Perpetual Maintenance'
                     OR [lic].[NAME_LicenseType_Cur] = 'SubscriptionLicense'
              )
           CROSS JOIN [Date]
      WHERE [orditem].[DTIME_OrderDate_Cur] <= [Date]
            AND [orditem].[SK_License_Master] > 0
      GROUP BY [lic].[ID_Source]
      )
, [License_x_OrderItem] AS (
  SELECT 
      [lic].[ID_Source]                                                                   AS [ID_SourceLicense]
      ,[orditem].[DTIME_OrderDate_Cur]                                                    AS [SK_Date_OrderDate]
      ,MAX([orditem].[CNT_Quantity_Cur])                                                  AS [CNT_Quantity]
      ,MAX(SK_OrderItem_Master)                                                           AS [SK_OrderItem_Master]
      ,SUM([orditem].[AMT_ExtendedAmount_USD_Cur])                                        AS [AMT_LastRevenue]
      ,MAX([orditem].[SK_Account_Master])                                                 AS [SK_Account_Order]
      ,MAX([orditem].[SK_Account_Master_Purchaser])                                       AS [SK_Account_Purchaser_Order]
      ,MAX([ordstat].[SK_User_Master_OrderOwner])                                         AS [SK_User_OrderOwner]
      ,STRING_AGG([ordstat].[NAME_OrderNumber_Cur],';')                                   AS [NAME_OrderID]
      ,STRING_AGG([ordstat].[URL_Source],';')                                             AS [CRM_Url_Order]
  FROM [DW_BUSINESS_PBI].[dbo].[PBI_F_OrderItem_Current] [orditem]
        JOIN [OrderItems] 
            ON [orditem].[DTIME_OrderDate_Cur] = [OrderItems].[MaxDate]
        JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_OrderStatus_Current] [ordstat] 
            ON ([ordstat].[SK_OrderStatus_Master] = [orditem].[SK_OrderStatus_Master]
            AND [ordstat].[NAME_Status_Cur] = 'Completed')
        JOIN [DW_BUSINESS_PBI].dbo.PBI_D_License_Current [lic] 
            ON ([orditem].[SK_License_Master] = [lic].[SK_License_Master] 
            AND [OrderItems].[ID_Source] = [lic].[ID_Source])
        JOIN [DW_BUSINESS_PBI].dbo.PBI_D_Product_Current [prd] 
            ON [prd].[SK_Product_Master] = [orditem].[SK_Product_Master]  
              AND ([prd].[NAME_ProductType_Cur] = 'Xperience Perpetual Maintenance'
                     OR [lic].[NAME_LicenseType_Cur] = 'SubscriptionLicense'
              )
  WHERE 1 = 1
        AND [AMT_ExtendedAmount_USD_Cur] >0
        AND [NAME_PaymentSource_Cur] <> 'ShareIt'
        AND [orditem].[SK_Date_ExpiresOn_Cur] BETWEEN DATEADD(day,-7,[lic].[SK_Date_ExpiresOn_Cur]) AND DATEADD(day,7,[lic].[SK_Date_ExpiresOn_Cur])
  GROUP BY [lic].ID_Source, [orditem].[DTIME_OrderDate_Cur]
  )
, [Opportunities_OppDate] as (
      SELECT
          [License].[SK_License_Master]
          ,MAX([opp].[DTIME_Inserted_Cur])                                                AS [MaxDate]
      FROM [License] AS [License]
            JOIN [DW_BUSINESS_PBI].[dbo].[PBI_F_Opportunity_Current] [opp]
                ON [opp].[SK_License_Master] = [License].SK_License_Master
            JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_OpportunityStatus_Current] [oppstat] 
                ON [oppstat].[SK_OpportunityStatus_Master] = [opp].[SK_OpportunityStatus_Master]
      WHERE [oppstat].[NAME_OpportunityType_Cur] = 'Renewal'
      GROUP BY [License].[SK_License_Master]
      )
, [Opportunities] AS (
  SELECT 
      [Opportunities_OppDate].[SK_License_Master]
      ,[opps].[NAME_State_Cur]                                                            AS [OppState]
      ,[License].[ID_Source_License] 
  FROM [Opportunities_OppDate]
        JOIN [DW_BUSINESS_PBI].[dbo].[PBI_F_Opportunity_Current] AS [opp] 
            ON ([opp].[SK_License_Master] = [Opportunities_OppDate].[SK_License_Master] 
            AND [Opportunities_OppDate].[MaxDate] = [DTIME_Inserted_Cur])
        JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_OpportunityStatus_Current] [opps] 
            ON [opps].[SK_OpportunityStatus_Master] = [opp].[SK_OpportunityStatus_Master]
        JOIN [License] AS [License] 
            ON [License].[SK_License_Master] = [Opportunities_OppDate].[SK_License_Master]
        WHERE MaxDate BETWEEN DATEADD(M,-4,[License].SK_Date_ExpiresOn_Cur) AND [License].SK_Date_ExpiresOn_Cur
 )
 , [PartnerDiscount] AS (
  SELECT
      DISTINCT ([partnership].[SK_Account_Master])                                        AS [SK_Account_Master]
      ,[partnerlevel].[NUM_Discount_Cur]                                                  AS [NUM_Discount_Cur]
  FROM [DW_BUSINESS_PBI].[dbo].[PBI_D_Partnership_Current] [partnership]
        JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_PartnerLevel_Current] AS [partnerlevel] 
            ON ([partnerlevel].[SK_PartnerLevel_Master] = [partnership].[SK_PartnerLevel_Master])
  WHERE [partnership].[NAME_PartnershipType_Cur] IN ('CMS/EMS', 'Xperience') 
        AND [partnership].[NAME_State_Cur] = 'Active'
 )
 , [FINAL] AS (
  SELECT
      [License].*
      ,[License_x_OrderItem].*
      ,[Purchaser].[NAME_AccountName_Cur]                                                 AS [AccountName_Purchaser]
      ,[Purchaser].[SK_Account_Master]                                                    AS [SK_Account_Master_Purchaser]
      ,[Purchaser].[ID_Source]                                                            AS [Purchaser_ID_Source]
      ,[Purchaser].[SK_Geography_Master]                                                  AS [SK_Geography_Master_Purchaser]
      ,[Discount_Account].[NUM_Discount_Cur]                                              AS [Discount_License_Account]
      ,[Discount_PArtner].[NUM_Discount_Cur]                                              AS [Discount_Partner]
      ,[Discount_Purchaser].[NUM_Discount_Cur]                                            AS [Discount_Purchaser]
      ,[Opportunities].[OppState]                                                         AS [Opportunity_State]
      ,ISNULL(CASE 
          WHEN [NAME_LicenseType_Cur] = 'SubscriptionLicense' THEN 
              CASE
              WHEN [License_x_OrderItem].[SK_Account_Purchaser_Order] > 0 THEN ROUND(([License].[AMT_MaintenancePriceUSD_Cur] * (1 - ISNULL([Discount_Purchaser].[NUM_Discount_Cur],0))),0)
              ELSE [License].[AMT_MaintenancePriceUSD_Cur]
              END
          ELSE 
              CASE
              WHEN [License_x_OrderItem].[SK_Account_Purchaser_Order] > 0 THEN ROUND(([License].[AMT_MaintenancePriceUSD_Cur] * (1 - ISNULL([Discount_Purchaser].[NUM_Discount_Cur],0))),0)
              WHEN [Discount_Account].[NUM_Discount_Cur] > 0 THEN ROUND(([License].[AMT_MaintenancePriceUSD_Cur] * (1 - [Discount_Account].[NUM_Discount_Cur])),0)
              WHEN [Discount_Partner].[NUM_Discount_Cur] > 0 THEN ROUND(([License].[AMT_MaintenancePriceUSD_Cur] * (1 - [Discount_Partner].[NUM_Discount_Cur])),0)
              ELSE [License].[AMT_MaintenancePriceUSD_Cur]
              END
          END
       ,0)                                                                               AS [MaintenancePriceDiscounted]
      ,ISNULL(CASE
          WHEN [License_x_OrderItem].[SK_Date_OrderDate] BETWEEN DATEADD(YEAR,-1,[Date].[Date]) AND DATEADD(DAY,-1,[Date].[Date]) THEN [License_x_OrderItem].[AMT_LastRevenue] 
          ELSE 0
       END,0)                                                                                AS [FY-1_Revenue]
  FROM [License] as [License]
        LEFT JOIN [License_x_OrderItem]                           AS [License_x_OrderItem] 
            ON [License_x_OrderItem].[ID_SourceLicense] = [License].[ID_Source_License]
        LEFT JOIN [DW_BUSINESS_PBI].[dbo].[PBI_D_Account_Current] AS [Purchaser] 
            ON ([Purchaser].[SK_Account_Master] = [License_x_OrderItem].[SK_Account_Purchaser_Order])
        LEFT JOIN [PartnerDiscount]                               AS [Discount_Account] 
            ON [Discount_Account].[SK_Account_Master] = [License].[SK_Account_Master]
        LEFT JOIN [PartnerDiscount]                               AS [Discount_PArtner] 
            ON [Discount_PArtner].[SK_Account_Master] = [License].[SK_Account_Master_Partner]
        LEFT JOIN [PartnerDiscount]                               AS [Discount_Purchaser]  
            ON [Discount_Purchaser].[SK_Account_Master] = [License_x_OrderItem].[SK_Account_Purchaser_Order]
        LEFT JOIN [Opportunities]                                 AS [Opportunities] 
            ON [Opportunities].[ID_Source_License] = [License].[ID_Source_License]
        CROSS JOIN [Date]
) 
,final2 AS (
  SELECT
       [Date]
      ,ISNULL([f].[SK_License_Master],-2)                                                     AS [SK_License_Master]
      ,ISNULL([f].[CRM_Url_License],'N/A')                                                    AS [CRM_Url_License]
      ,ISNULL([f].[CRM_Url_Order],'N/A')                                                      AS [CRM_Url_Order]
      ,ISNULL([f].[ID_Source_License],'N/A')                                                  AS [ID_Source_License]
      ,ISNULL([f].[ID_Source_Account],'N/A')                                                  AS [ID_Source_Account]
      ,ISNULL([f].[ID_Source_AccountPartner],'N/A')                                           AS [ID_Source_AccountPartner]
      ,ISNULL([NAME_LicenseType_Cur],'N/A')                                                   AS [NAME_LicenseType_Cur] 
      ,ISNULL([f].[ID_Source_AccountManager],'N/A')                                           AS [ID_Source_AccountManager]
      ,ISNULL([f].[SK_User_Master_AccountManager],-1)                                         AS [SK_User_Master_AccountManager]
      ,ISNULL([f].[SK_Account_Master],-2)                                                     AS [SK_Account_License_Master]
      ,ISNULL([f].[SK_Geography_Master],-2)                                                   AS [SK_Geography_License_Master]
      ,ISNULL([f].[SK_Account_Master_Parent],-2)                                              AS [SK_Account_License_Master_Parent]
      ,ISNULL([f].[SK_Account_Master_Partner],-2)                                             AS [SK_Account_License_Master_Partner]
      ,ISNULL([f].[SK_Account_Master_Purchaser],-2)                                           AS [SK_Account_License_Master_Purchaser]
      ,ISNULL([f].[SK_Product_Master],-2)                                                     AS [SK_Product_Master]
      ,ISNULL([f].[SK_Contact_Master],-2)                                                     AS [SK_Contact_Master]
      ,ISNULL([f].[SK_Account_Order],-2)                                                      AS [SK_Account_Order]
      ,ISNULL([f].[SK_Account_Purchaser_Order],-2)                                            AS [SK_Account_Purchaser_Order]
      ,ISNULL([geopurchaser].[SK_Geography_Master],-2)                                        AS [SK_Geography_Purchaser_Order]
      ,ISNULL([f].[SK_User_OrderOwner],-2)                                                    AS [SK_User_OrderOwner]
      ,ISNULL([f].[SK_Date_ExpiresOn_Cur],'1800-01-01')                                       AS [SK_Date_ExpiresOn_Cur]
      ,ISNULL([f].[SK_Date_BasePricing_Cur],'1800-01-01')                                     AS [SK_Date_BasePricing_Cur]
      ,ISNULL([f].[SK_Date_Purchase_Cur],'1800-01-01')                                        AS [SK_Date_Purchase_Cur]
      ,ISNULL([f].[SK_Date_LastUpgrade_Cur],'1800-01-01')                                     AS [SK_Date_LastUpgrade_Cur]
      ,ISNULL([f].[SK_Date_OrderDate],'1800-01-01')                                           AS [SK_Date_OrderDate]
      ,ISNULL([f].[Opportunity_State],'N/A')                                                  AS [NAME_OpportunityState]
      ,ISNULL([f].[NAME_OrderID],'N/A')                                                       AS [NAME_OrderID]
      ,ISNULL([f].[Discount_License_Account],0)                                               AS [NUM_Discount_License_Account]
      ,ISNULL([f].[Discount_Partner],0)                                                       AS [NUM_Discount_Partner]
      ,ISNULL([f].[Discount_Purchaser],0)                                                     AS [NUM_Discount_Purchaser]
      ,ISNULL([f].[CNT_Quantity],0)                                                           AS [CNT_Quantity]
      ,ISNULL(CONVERT(MONEY,[f].[AMT_MaintenancePriceUSD_Cur]),0)							  AS [AMT_MaintenancePriceUSD_Cur]
      ,ISNULL(CONVERT(MONEY,[f].[MaintenancePriceDiscounted]),0)                              AS [AMT_MaintenancePriceDiscounted]
      ,ISNULL(CONVERT(MONEY,[f].[FY-1_Revenue]),0)                                            AS [AMT_FY-1_Revenue]
      ,ISNULL(CONVERT(MONEY,[f].[AMT_LastRevenue]),0)                                         AS [AMT_LastRevenue]
      ,CONVERT(MONEY,CASE
                        WHEN [NAME_LicenseType_Cur] = 'SubscriptionLicense' THEN [f].[MaintenancePriceDiscounted]   
                        WHEN [f].[FY-1_Revenue] > 0 AND [f].[CNT_Quantity] = 1 THEN [f].[AMT_LastRevenue] 
                        ELSE [f].[MaintenancePriceDiscounted]
                     END)                                                                 AS [AMT_ExpectedRevenue_calc]
  FROM [FINAL] [f]
        LEFT JOIN [DW_BUSINESS_PBI].dbo.PBI_D_Account_Current [accountpurchaser] 
          ON [f].[SK_Account_Purchaser_Order] = [accountpurchaser].[SK_Account_Master]
        LEFT JOIN [DW_BUSINESS_PBI].dbo.PBI_D_Geography_Current [geopurchaser] 
          ON [accountpurchaser].[SK_Geography_Master] = [geopurchaser].[SK_Geography_Master]
),
-- update because of expected revenue higher than maintenance price discounted
recalcul_lic_cur as (
	SELECT final2.*
	 	,case when [AMT_MaintenancePriceDiscounted] > [AMT_ExpectedRevenue_calc]
	 		then [AMT_ExpectedRevenue_calc]
		else [AMT_MaintenancePriceDiscounted]
		end                                                                                   AS [AMT_ExpectedRevenue]
	 FROM final2
	 ),
lic_cur as
	( -- actual information of licenses
		select
			pdlc2.SK_License_Master 
			, pdlc2.NAME_LicenseType_Cur 
			, pdlc2.SK_Date_ExpiresOn_Cur 
			, pdlc2.AMT_ExpectedRevenue 
		FROM 
			recalcul_lic_cur pdlc2 
		inner join
			lic_poi
				on lic_poi.SK_License_Master = pdlc2.SK_License_Master 
	)
select
	lic_poi.SK_License_Master
	, [URL License] = lic_poi.CRM_Url_License
	, [Project Name] = lic_poi.NAME_ProjectName_Cur
	, lic_poi.[Account Name]
	, [Partner Name] = lic_poi.Partner_name
	, lic_poi.[Account Territory]
        , lic_poi.[Account Region]
	, [Owner/AM] = lic_poi.owner
	, [License Type July 2021] = lic_poi.NAME_LicenseType_Cur
	, [License Purchase] = SK_Date_Purchase_Cur
	, [Expected Revenue FY22] = lic_poi.AMT_ExpectedRevenue -- revenue on license with discounts from state on Jul 21 2021
	, [Expiration of License July 2021] = lic_poi.SK_Date_ExpiresOn_Cur
	, [License Type Current] = lic_cur.NAME_LicenseType_Cur
	, [Expiration of License Current] = lic_cur.SK_Date_ExpiresOn_Cur
	, [Expected Revenue Current] = -- Expected future revenue/maintenance price after discounts
		-- when license is already lost, we are not interested to future mainteneance
		case when (final_ord.[Order Number g] is null and final_opp.[Opportunity State] = 'Lost') then 0
			else lic_cur.AMT_ExpectedRevenue end
	, [Opportunity inserted] = final_opp.[DATE Inserted]
	, final_opp.[Opportunity Name]
	, final_opp.[Opportunity Type]
	, final_opp.[Opportunity State]
	, [Oppurtinity URL] = final_opp.URL_Source
	, [Order type] = final_ord.order_type
	, [Order number] = final_ord.[Order Number g]
	, final_ord.[Order Status]
	, [Order Total Revenue] = final_ord.total_revenue_license_g
	, [Order MRR calculation] = final_ord.MRR_perpetual_license_g
	, [Order Multiyear Extra Money] = final_ord.Multiyear_extra_money_g
	, [Order Service Money] = final_ord.Service_extra_money_g
	, [Order Paid] = final_ord.DTIME_Order_Paid
	, [Order URL] = final_ord.URL_Source
	, [Order Product start on] = final_ord.MIN_DATE_Start_On_g
	, [Order Product expire on] = final_ord.MAX_DATE_Expire_On_g
	, [Order Contract length] = final_ord.[Contract lenght]
	, [Already expired] = 
		case when
			lic_cur.SK_Date_ExpiresOn_Cur < getdate()
		then
			'expired' -- actual expiration of license is in the past
		else
			'current' -- actual expiration of license is today or in future
		end
	, [Result] = 
		/* clasification of the switch:
		 * S (subscription switch) = Some >paid order and License July 21 is perpetual and License current is subscription
		 * P (Maintenance) = Some >paid order and License July 21 and current are perpetual
		 * L (Lost) = Opp state Lost and Order is null
		 * N (Not decided) = Opp state <> Lost and Order is null
		 * N/A = no opp, ord -> account was not contacted about prolong of license yet
		 */
		case when
			-- subscription switch in INVOICED status
			(final_ord.[Order Number g] is not null
				and final_ord.order_type = 'subscription'
				and final_ord.[Order Status] = 'Invoiced')
			then 'S_(I)'
		when
			-- subscription switch
			(final_ord.[Order Number g] is not null and lic_poi.NAME_LicenseType_Cur = 'Perpetual' 
				and lic_cur.NAME_LicenseType_Cur = 'SubscriptionLicense')
			then 'S'
		when
			-- Maintenance in INVOICED status
			(final_ord.[Order Number g] is not null
				and lic_cur.NAME_LicenseType_Cur = 'perpetual'
				and final_ord.[Order Status] = 'Invoiced')
			then 'P_(I)'
		when 
			-- Maintenance
			(final_ord.[Order Number g] is not null and lic_poi.NAME_LicenseType_Cur = 'Perpetual' 
				and lic_cur.NAME_LicenseType_Cur = 'Perpetual')
			then 'P'
		when
			-- Lost
			(final_ord.[Order Number g] is null and final_opp.[Opportunity State] = 'Lost')
			then 'L'
		when
			-- Not decided
			(final_ord.[Order Number g] is null and final_opp.[Opportunity State] <> 'Lost')
			then 'N'
		when
			-- N/A
			(final_ord.[Order Number g] is null and final_opp.[Opportunity State] is null)
			then 'N/A'
		else 'Not clasificed'
		end
	, [Estimated price FY22] = -- ARR of order
		final_ord.MRR_perpetual_license_g * 12
	, [diff of ARR] = -- diff of ARR order FY22 and expected maintenance FY22
		ISNULL((final_ord.MRR_perpetual_license_g * 12),0) - lic_poi.AMT_ExpectedRevenue
	, [diff of maintenances] = -- diff of expected maintenance FY22 and new maintenance on license with discounts
		case when (final_ord.[Order Number g] is null and final_opp.[Opportunity State] = 'Lost') then 0
			else lic_cur.AMT_ExpectedRevenue - lic_poi.AMT_ExpectedRevenue end
from
	lic_poi
left join
	final_opp
		on lic_poi.SK_License_Master = final_opp.SK_License_Master
left JOIN 
	final_ord
		on lic_poi.SK_License_Master = final_ord.SK_License_Master
			and final_ord.rn=1
left join
	lic_cur
		on lic_poi.SK_License_Master = lic_cur.SK_License_Master
