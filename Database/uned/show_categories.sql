/*******************************************************************************
 * 显示所有分类
 * 返回：category表中所有信息
 ******************************************************************************/
DELIMITER //
CREATE PROCEDURE `show_categories` ()
begin 
	SELECT * FROM `category`;
end//
DELIMITER ;
