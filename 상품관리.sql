commit;

-- crud category
-- list
select category_no, category_name from product_category order by category_no desc;

-- view
select category_no, category_name from product_category where category_no = 1;

-- insert
insert into product_category (category_no, category_name)
values(product_category_seq.nextval, '매');

insert into product_category (category_no, category_name)
values(product_category_seq.nextval, '책상');

-- update
update product_category set category_name = '옷장' where category_no = 1;

-- delete
delete from product_category where category_no = 1;

-- crud product
-- list
select item_no,  item_title, item_thum, item_status, 
item_price from(select rownum rnum, item_no,  item_title, item_thum, item_status, 
item_price from(
select p.item_no,  p.item_title, p.item_thum, p.item_status, c.category_no,
p.item_price from product_item p, product_category c 
where  p.category_no = 2 and (c.category_no = p.category_no)
 order by p.item_no desc
)
)
where rnum between 1 and 5;
-- view
select item_no, item_title,
		item_thum, item_img, item_status, item_content,
		item_price from
		product_item where item_no = 1;

-- insert
insert into product_item(item_no, item_title,
item_thum, item_img, item_content, item_price, category_no)VALUES
(product_item_seq.nextval, '나이키의자', 'chair.jpg', 'viewchair.jpg', '좋은상품', '10,000,000', 1);

-- update
update product_item set item_title = '아디다스의자' , item_thum = 'adchair.jpg',
item_img = 'ddd.jpg' , item_content='안좋은상품' , item_price='10,202,000',
item_status= '재고있음' where item_no = 1;

-- delete
delete from product_item where item_no = 1;

-- crud option
-- list
select o.option_no, o.option_name, o.option_price, o.option_info, p.item_no
from product_option o, product_item p 
where (o.item_no = p.item_no) and p.item_no=1 order by option_no desc;

-- insert
insert into product_option (option_no, option_name, option_price, option_info, item_no)
VALUES(product_option_seq.nextval, '상품코드', '1000', '노랑색S사이즈', 1);
insert into product_option (option_no, option_name, option_price, option_info, item_no) 
VALUES(product_option_seq.nextval,'asd', '1000', 'asd', 2);
commit;
-- update
update product_option set option_name = '상품코드변경', option_price='옵션가격변경',
option_info='옵션정보 변경' where option_no = 1;

--delete
delete from product_option where option_no = 1;

select item_no, item_title, item_thum, item_status, item_price from(select rownum rnum, item_no, 
item_title, item_thum, item_status, item_price from( select p.item_no, p.item_title, p.item_thum, 
p.item_status, c.category_no, p.item_price from product_item p, product_category c where p.category_no 
= 1 and (c.category_no = p.category_no) order by p.item_no desc ) ) where rnum between 1 and 
8;
select count(*)
		from product_item;



