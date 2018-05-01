<?php

class AjaxController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        // action body
        $dbD = new Model_DbTable_Doc();
        $arr = $dbD->getAll();
        $this->view->result = $arr;
    }

    public function ecrireAction()
    {
        $dbD = new Model_DbTable_Doc();
        $dbD->ajouter(array("titre"=>$this->_getParam('title', 'rien')));
    }
    
    
}

