/*
 * file: src/util/logger.h
 * author: Josue Teodoro Moreira <teodoro.josue@protonmail.ch>
 * date: 27 August, 2022
 *
 * Copyright (C) 2022, Josue Teodoro Moreira                               
 *                                                                         
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by    
 * the Free Software Foundation, either version 3 of the License, or       
 * (at your option) any later version.                                     
 *                                                                         
 * This program is distributed in the hope that it will be useful,         
 * but WITHOUT ANY WARRANTY; without even the implied warranty of          
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the          
 * GNU General Public License for more details.                            
 *                                                                         
 * You should have received a copy of the GNU General Public License       
 * along with this program.	 If not, see <https://www.gnu.org/licenses/>.
 */

#include "../core.h"

#define PLAIN_LOG_INFO "INFO"
#define PLAIN_LOG_WARNING "WARNING"
#define PLAIN_LOG_ERROR "ERROR"

struct plain_log_t
{
  char *type;
  char *msg;
  char *json;
};

void plain_log
(
  struct plain_log_t *_log
);
