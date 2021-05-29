package com.wq.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Books {
    // 字段名称尽量和数据库一模一样
    private int bookID;
    private String bookName;
    private int bookCounts;
    private String detail;
}
