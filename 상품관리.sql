commit;

-- crud category
-- list
select category_no, category_name from product_category order by category_no desc;

-- view
select category_no, category_name from product_category where category_no = 1;

-- insert
insert into product_category (category_no, category_name)
values(product_category_seq.nextval, '��');

insert into product_category (category_no, category_name)
values(product_category_seq.nextval, 'å��');

-- update
update product_category set category_name = '����' where category_no = 1;

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
(product_item_seq.nextval, '����Ű����', 'chair.jpg', 'viewchair.jpg', '������ǰ', '10,000,000', 1);

-- update
update product_item set item_title = '�Ƶ�ٽ�����' , item_thum = 'adchair.jpg',
item_img = 'ddd.jpg' , item_content='��������ǰ' , item_price='10,202,000',
item_status= '�������' where item_no = 1;

-- delete
delete from product_item where item_no = 1;

-- crud option
-- list
select o.option_no, o.option_name, o.option_price, o.option_info, p.item_no
from product_option o, product_item p 
where (o.item_no = p.item_no) and p.item_no=1 order by option_no desc;

-- insert
insert into product_option (option_no, option_name, option_price, option_info, item_no)
VALUES(product_option_seq.nextval, '��ǰ�ڵ�', '1000', '�����S������', 1);
insert into product_option (option_no, option_name, option_price, option_info, item_no) 
VALUES(product_option_seq.nextval,'asd', '1000', 'asd', 2);
commit;
-- update
update product_option set option_name = '��ǰ�ڵ庯��', option_price='�ɼǰ��ݺ���',
option_info='�ɼ����� ����' where option_no = 1;

--delete
delete from product_option where option_no = 1;

select item_no, item_title, item_thum, item_status, item_price from(select rownum rnum, item_no, 
item_title, item_thum, item_status, item_price from( select p.item_no, p.item_title, p.item_thum, 
p.item_status, c.category_no, p.item_price from product_item p, product_category c where p.category_no 
= 1 and (c.category_no = p.category_no) order by p.item_no desc ) ) where rnum between 1 and 
8;
select count(*)
		from product_item;



